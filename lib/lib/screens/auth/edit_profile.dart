import 'dart:io';
import 'dart:typed_data';
import 'dart:convert'; // 🟢 Added for json decoding
import 'package:http/http.dart' as http; // 🟢 Added for Cloudinary upload
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gal/gal.dart';
import '../../theme/app_colors.dart';

// Cloudinary Credentials
const String cloudName = "dl484kobd";
const String uploadPreset = "unsigned_preset";

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? _imageFile;
  String? _currentImageUrl; // 🟢 To track the existing image from database
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserData();
  }

  Future<void> _loadCurrentUserData() async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return;

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = data['username'] ?? '';
          _bioController.text = data['bio'] ?? '';
          _currentImageUrl = data['profileImageUrl']; // 🟢 Load existing image URL
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("Error loading profile: $e");
    }
  }

  // ☁️ Cloudinary Upload Function
  Future<String?> _uploadToCloudinary(File imageFile) async {
    final uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    try {
      final request = http.MultipartRequest("POST", uri);
      request.fields["upload_preset"] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath("file", imageFile.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = json.decode(await response.stream.bytesToString());
        return responseData["secure_url"]; // Returns the web link
      } else {
        debugPrint("Cloudinary Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Upload Exception: $e");
      return null;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? photo = await picker.pickImage(
        source: source,
        maxWidth: 512,
        imageQuality: 75,
      );

      if (photo != null) {
        setState(() {
          _imageFile = File(photo.path);
        });

        if (source == ImageSource.camera) {
          Uint8List bytes = await photo.readAsBytes();
          await Gal.putImageBytes(bytes);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Image saved to gallery!")),
            );
          }
        }
      }
    } catch (e) {
      debugPrint("Error picking/saving image: $e");
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.sunsetPurple,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text('Photo Gallery', style: TextStyle(color: Colors.white)),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Colors.white),
                title: const Text('Camera', style: TextStyle(color: Colors.white)),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleSave() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Username cannot be empty")));
      return;
    }

    setState(() => _isSaving = true);

    try {
      String? uid = _auth.currentUser?.uid;
      if (uid != null) {
        String? finalImageUrl = _currentImageUrl;

        // 🟢 1. Upload to Cloudinary if a new image was picked
        if (_imageFile != null) {
          String? uploadedUrl = await _uploadToCloudinary(_imageFile!);
          if (uploadedUrl != null) {
            finalImageUrl = uploadedUrl;
          }
        }

        // 🟢 2. Update Firestore with text AND the new URL
        await _firestore.collection('users').doc(uid).update({
          'username': _nameController.text.trim(),
          'bio': _bioController.text.trim(),
          'profileImageUrl': finalImageUrl, // Saved to DB
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated Successfully!")));
          Navigator.pop(context);
        }
      }
    } catch (e) {
      setState(() => _isSaving = false);
      debugPrint("Save error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  const Text('Edit Profile', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.goldText, fontFamily: 'PlayfairDisplay')),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () => _showPicker(context),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white24,
                          // 🟢 Show local file if picked, otherwise show network image from DB
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : (_currentImageUrl != null ? NetworkImage(_currentImageUrl!) : null) as ImageProvider?,
                          child: (_imageFile == null && _currentImageUrl == null)
                              ? Text(
                            _nameController.text.isNotEmpty ? _nameController.text[0].toUpperCase() : '?',
                            style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                          )
                              : null,
                        ),
                        Positioned(
                          bottom: 0, right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(color: AppColors.sunsetOrange, shape: BoxShape.circle),
                            child: const Icon(Icons.add, size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextField(controller: _nameController, style: const TextStyle(color: Colors.white), decoration: _inputDecoration('Username')),
                  const SizedBox(height: 20),
                  TextField(controller: _bioController, maxLines: 3, style: const TextStyle(color: Colors.white), decoration: _inputDecoration('Bio')),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _handleSave,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.sunsetOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      child: _isSaving
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.white70, fontFamily: 'PlayfairDisplay'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.goldText),
      filled: true,
      fillColor: Colors.black.withOpacity(0.3),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
    );
  }
}