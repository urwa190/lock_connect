import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/post_card.dart';
import '../models/post_model.dart';
import 'notifications_screen.dart';
import 'threads_screen.dart';
import 'thread_creation_screen.dart';
import 'preview_screens.dart'; // 🌟 Make sure to create this file!
import '../../theme/AppColors.dart';
import '../backend/firebase_auth.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreens> {
  int _selectedIndex = 0;
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = mockAuth;

  static const String cloudName = "dl484kobd";
  static const String uploadPreset = "unsigned_preset";

  // --- 🌟 NEW: CAMERA ACTION (PHOTO OR VIDEO + PREVIEW) ---
  Future<void> _handleCameraAction() async {
    // pickMedia allows the user to use the full camera UI (Photo or Video)
    final XFile? pickedFile = await _picker.pickMedia();

    if (pickedFile == null) return;

    File file = File(pickedFile.path);
    bool isVideo = pickedFile.path.toLowerCase().endsWith('.mp4') ||
        pickedFile.path.toLowerCase().endsWith('.mov');

    // Send to Preview Screen
    if (!mounted) return;
    final bool? shouldPost = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(file: file, isVideo: isVideo),
      ),
    );

    // If user clicked 'POST' on the preview screen
    if (shouldPost == true) {
      _startUploadProcess(file, isVideo);
    }
  }

  // --- 🌟 DIRECT GALLERY PICKING ---
  Future<void> _handleDirectGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    File file = File(pickedFile.path);

    if (!mounted) return;
    final bool? shouldPost = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(file: file, isVideo: false),
      ),
    );

    if (shouldPost == true) {
      _startUploadProcess(file, false);
    }
  }

  // --- 🌟 ACTUAL UPLOAD LOGIC ---
  Future<void> _startUploadProcess(File file, bool isVideo) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Uploading to Rekindl..."), backgroundColor: AppColors.sunsetPurple),
    );

    try {
      final uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/auto/upload");
      final request = http.MultipartRequest("POST", uri);
      request.fields["upload_preset"] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath("file", file.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = json.decode(await response.stream.bytesToString());
        String secureUrl = responseData["secure_url"];

        await FirebaseFirestore.instance.collection('posts').add({
          'authorName': _auth.currentUser?.displayName ?? 'Rekindl Tester',
          'authorAvatarUrl': _auth.currentUser?.photoURL ?? 'assets/logo.png',
          'caption': isVideo ? 'Shared a new video' : 'Shared a new photo',
          'mediaUrl': secureUrl,
          'isThread': false,
          'isVideo': isVideo,
          'timestamp': FieldValue.serverTimestamp(),
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Posted successfully!"), backgroundColor: Colors.green),
          );
        }
      }
    } catch (e) {
      debugPrint("Upload error: $e");
    }
  }

  void _showCreateMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.forum, color: Colors.white),
              title: const Text("Post a Thread", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ThreadCreationScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.image, color: Colors.white),
              title: const Text("Post a Picture", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _handleDirectGallery(); // 🌟 Leads directly to gallery
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text("Camera", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _handleCameraAction(); // 🌟 Opens camera for photo/video
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("Rekindl", style: TextStyle(fontFamily: 'PlayfairDisplay', color: AppColors.goldText, fontSize: 24, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen(userName: 'User'))),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.goldText));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No memories yet.", style: TextStyle(color: Colors.white)));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    final post = PostModel(
                      id: doc.id,
                      authorName: data['authorName'] ?? 'Member',
                      authorAvatarUrl: data['authorAvatarUrl'] ?? 'assets/logo.png',
                      caption: data['caption'] ?? '',
                      mediaUrl: data['mediaUrl'] ?? '',
                      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
                      isThread: data['isThread'] ?? false,
                      isVideo: data['isVideo'] ?? false,
                      videoPath: data['isVideo'] == true ? (data['mediaUrl'] ?? '') : '',
                    );

                    return PostCard(post: post);
                  },
                );
              },
            ),
          ),
        ],
      );
    } else {
      return const ThreadsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
              begin: Alignment.topCenter, end: Alignment.bottomCenter
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: _buildBody()),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black.withValues(alpha: 0.6),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: _selectedIndex,
          onTap: (index) => index == 2 ? _showCreateMenu() : setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Posts'),
            BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Threads'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Create'),
          ],
        ),
      ),
    );
  }
}