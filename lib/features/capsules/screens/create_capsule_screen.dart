import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lock_connect/core/constants/colors.dart';
import 'package:lock_connect/core/constants/app_colors.dart';
import '../models/capsule.dart';
import '../services/capsule_service.dart';
import 'add_collaborators_screen.dart'; // Import Screen 15
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'capsule_detail_screen.dart';


const Color kAppBarForeground = Colors.white;
const Color kDarkCardBackground = Color(0xFF1E1E1E);


class CreateCapsuleScreen extends StatefulWidget {
  final CapsuleService capsuleService;
  const CreateCapsuleScreen({super.key, required this.capsuleService});

  @override
  State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
}

class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  bool _isPrivate = false;
  File? _coverFile;
  bool _saving = false;

  Future<void> _pickCover() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) setState(() => _coverFile = File(picked.path));
  }

  Future<void> _create() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final capsule = Capsule(
      id: '',
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      ownerId: uid,
      isPrivate: _isPrivate,
      coverImageUrl: '',
      collaborators: const [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    try {
      final id = await widget.capsuleService.createCapsule(capsule, coverFile: _coverFile);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CapsuleDetailScreen(
            capsuleId: id,
            capsuleService: widget.capsuleService,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Capsule')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              SwitchListTile(
                value: _isPrivate,
                onChanged: (v) => setState(() => _isPrivate = v),
                title: const Text('Private capsule'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickCover,
                    icon: const Icon(Icons.image),
                    label: const Text('Pick cover'),
                  ),
                  const SizedBox(width: 12),
                  if (_coverFile != null) const Text('Cover selected'),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saving ? null : _create,
                child: _saving
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}