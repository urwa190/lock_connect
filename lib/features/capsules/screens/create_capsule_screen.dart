// //
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:lock_connect/core/constants/colors.dart';
// // import 'package:lock_connect/core/constants/app_colors.dart';
// //
// // // Internal project imports
// // import '../../../lib/backend/services/cloudinary_config.dart';
// // import '../models/capsule.dart';
// // import '../services/capsule_service.dart';
// // import '../services/cloudinary_upload.dart';
// // import 'add_collaborators_screen.dart';
// //
// // const Color kAppBarForeground = Colors.white;
// // const Color kDarkCardBackground = Color(0xFF1E1E1E);
// //
// // class CreateCapsuleScreen extends StatefulWidget {
// //   const CreateCapsuleScreen({super.key});
// //
// //   @override
// //   State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
// // }
// //
// // class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
// //   // --- CONTROLLERS & SERVICES ---
// //   final _titleController = TextEditingController();
// //   final _noteController = TextEditingController();
// //   late final CapsuleService _capsuleService;
// //
// //   // --- STATE VARIABLES ---
// //   DateTime? _selectedDate;
// //   TimeOfDay? _selectedTime;
// //
// //   // Stores names for UI and UIDs for Firebase
// //   List<String> _collaboratorNames = [];
// //   List<String> _collaboratorUids = [];
// //
// //   File? _selectedMedia;
// //   bool _isSaving = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Initialized with your CloudinaryConfig class
// //     _capsuleService = CapsuleService(
// //       uploader: CloudinaryUploader(
// //         cloudName: CloudinaryConfig.cloudName,
// //         uploadPreset: CloudinaryConfig.uploadPreset,
// //       ),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _titleController.dispose();
// //     _noteController.dispose();
// //     super.dispose();
// //   }
// //
// //   // --- LOGIC METHODS ---
// //
// //   Future<void> _pickMedia() async {
// //     final picker = ImagePicker();
// //     final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
// //     if (picked != null) {
// //       setState(() => _selectedMedia = File(picked.path));
// //       _showSnackBar('Media attached!', isError: false);
// //     }
// //   }
// //
// //   Future<void> _selectDate() async {
// //     final DateTime? pickedDate = await showDatePicker(
// //       context: context,
// //       initialDate: DateTime.now().add(const Duration(days: 1)),
// //       firstDate: DateTime.now().add(const Duration(days: 1)),
// //       lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
// //     );
// //
// //     if (pickedDate != null) {
// //       setState(() => _selectedDate = pickedDate);
// //       _selectTime();
// //     }
// //   }
// //
// //   Future<void> _selectTime() async {
// //     final TimeOfDay? pickedTime = await showTimePicker(
// //       context: context,
// //       initialTime: TimeOfDay.now(),
// //     );
// //     if (pickedTime != null) setState(() => _selectedTime = pickedTime);
// //   }
// //
// //   void _navigateToAddCollaborators() async {
// //     // Result comes back as List<Map<String, String>> from your new screen
// //     final result = await Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (context) => const AddCollaboratorsScreen()),
// //     );
// //
// //     if (result != null && result is List<Map<String, String>>) {
// //       setState(() {
// //         _collaboratorNames = result.map((e) => e['name']!).toList();
// //         _collaboratorUids = result.map((e) => e['uid']!).toList();
// //       });
// //     }
// //   }
// //
// //   Future<void> _handleSealCapsule() async {
// //     if (_titleController.text.trim().isEmpty || _selectedDate == null) {
// //       _showSnackBar('Title and Date are required');
// //       return;
// //     }
// //
// //     setState(() => _isSaving = true);
// //
// //     try {
// //       final user = FirebaseAuth.instance.currentUser;
// //       final unlockDateTime = DateTime(
// //         _selectedDate!.year, _selectedDate!.month, _selectedDate!.day,
// //         _selectedTime?.hour ?? 0, _selectedTime?.minute ?? 0,
// //       );
// //
// //       // 1. Create Capsule Main Document
// //       final capsule = Capsule(
// //         id: '',
// //         title: _titleController.text.trim(),
// //         description: '',
// //         ownerId: user!.uid,
// //         isPrivate: true,
// //         isLocked: true,
// //         unlockAt: unlockDateTime,
// //         collaborators: _collaboratorUids, // Saving real UIDs for security rules
// //         coverImageUrl: '',
// //         createdAt: DateTime.now(),
// //         updatedAt: DateTime.now(), // Field now enabled in your model
// //       );
// //
// //       final capsuleId = await _capsuleService.createCapsule(capsule, coverFile: _selectedMedia);
// //
// //       // 2. Create Content Subcollection for the note
// //       if (_noteController.text.trim().isNotEmpty) {
// //         await _capsuleService.addTextContent(capsuleId, _noteController.text.trim(), user.uid);
// //       }
// //
// //       if (mounted) {
// //         _showSnackBar('New capsule created!', isError: false);
// //         Navigator.pop(context);
// //       }
// //     } catch (e) {
// //       _showSnackBar('Error: ${e.toString()}');
// //     } finally {
// //       if (mounted) setState(() => _isSaving = false);
// //     }
// //   }
// //
// //   void _showSnackBar(String message, {bool isError = true}) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
// //         backgroundColor: isError ? Colors.red : AppColors.sunsetPurple,
// //         behavior: SnackBarBehavior.floating,
// //       ),
// //     );
// //   }
// //
// //   // --- UI BUILDING ---
// //
// //   Widget _buildCardContainer({required Widget child}) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(16.0),
// //       decoration: BoxDecoration(
// //         color: kDarkCardBackground.withOpacity(0.60),
// //         borderRadius: BorderRadius.circular(16.0),
// //       ),
// //       child: child,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     const titleStyle = TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Roboto');
// //
// //     return Container(
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
// //           begin: Alignment.topCenter, end: Alignment.bottomCenter,
// //         ),
// //       ),
// //       child: Scaffold(
// //         backgroundColor: Colors.transparent,
// //         appBar: AppBar(
// //           backgroundColor: Colors.transparent, elevation: 0,
// //           title: Text('Create Capsule', style: TextStyle(fontFamily: 'PlayfairDisplay', color: AppColors.goldText, fontWeight: FontWeight.bold)),
// //         ),
// //         body: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             children: [
// //               _buildCardContainer(
// //                 child: TextField(
// //                   controller: _titleController,
// //                   style: const TextStyle(color: Colors.white),
// //                   decoration: InputDecoration(
// //                     labelText: 'Capsule Title', labelStyle: titleStyle,
// //                     hintText: 'e.g., Summer Memories', hintStyle: TextStyle(color: Colors.white30),
// //                     border: InputBorder.none, suffixIcon: const Icon(Icons.lock, color: Colors.white70),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               _buildCardContainer(
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         const Text('Collaborators', style: titleStyle),
// //                         Text(_collaboratorNames.isEmpty ? 'None added' : _collaboratorNames.join(', '),
// //                             style: const TextStyle(color: Colors.white70, fontSize: 12)),
// //                       ],
// //                     ),
// //                     IconButton(icon: const Icon(Icons.person_add, color: AppColors.sunsetOrange), onPressed: _navigateToAddCollaborators),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               _buildCardContainer(
// //                 child: ListTile(
// //                   contentPadding: EdgeInsets.zero,
// //                   title: const Text('Unlock Time', style: titleStyle),
// //                   subtitle: Text(_selectedDate == null ? 'Not set' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
// //                   trailing: const Icon(Icons.calendar_today, color: AppColors.sunsetOrange),
// //                   onTap: _selectDate,
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               _buildCardContainer(
// //                 child: Column(
// //                   children: [
// //                     TextField(
// //                       controller: _noteController, maxLines: 3,
// //                       style: const TextStyle(color: Colors.white),
// //                       decoration: InputDecoration(hintText: 'Add a memory note...', hintStyle: TextStyle(color: Colors.white30), border: InputBorder.none),
// //                     ),
// //                     Row(
// //                       children: [
// //                         ElevatedButton.icon(onPressed: _pickMedia, icon: const Icon(Icons.image), label: const Text('Photos')),
// //                         if (_selectedMedia != null) const Icon(Icons.check_circle, color: Colors.green),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 40),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: _isSaving ? null : _handleSealCapsule,
// //                   style: ElevatedButton.styleFrom(backgroundColor: AppColors.sunsetOrange, padding: const EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
// //                   child: _isSaving ? const CircularProgressIndicator(color: Colors.white) : const Text('Seal Capsule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lock_connect/core/constants/app_colors.dart';
// import '../../../lib/backend/services/cloudinary_config.dart';
// import '../models/capsule.dart';
// import '../services/capsule_service.dart';
// import '../services/cloudinary_upload.dart';
// import 'add_collaborators_screen.dart';
//
// class CreateCapsuleScreen extends StatefulWidget {
//   const CreateCapsuleScreen({super.key});
//   @override
//   State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
// }
//
// class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
//   final _titleController = TextEditingController();
//   final _noteController = TextEditingController();
//   late final CapsuleService _capsuleService;
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   List<String> _collaboratorUids = [];
//   List<String> _collaboratorNames = [];
//   List<File> _selectedMediaList = []; // List for multiple media
//   bool _isSaving = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _capsuleService = CapsuleService(
//       uploader: CloudinaryUploader(
//         cloudName: CloudinaryConfig.cloudName,
//         uploadPreset: CloudinaryConfig.uploadPreset,
//       ),
//     );
//   }
//
//   Future<void> _pickMedia() async {
//     final List<XFile> picked = await ImagePicker().pickMultiImage(imageQuality: 85);
//     if (picked.isNotEmpty) {
//       setState(() => _selectedMediaList = picked.map((f) => File(f.path)).toList());
//     }
//   }
//
//   Future<void> _handleSealCapsule() async {
//     if (_titleController.text.isEmpty || _selectedDate == null) return;
//     setState(() => _isSaving = true);
//
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       final unlockAt = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, _selectedTime?.hour ?? 0, _selectedTime?.minute ?? 0);
//
//       // 1. Create main capsule (Strictly NO coverImageUrl)
//       final capsuleId = await _capsuleService.createCapsule(Capsule(
//         id: '', title: _titleController.text.trim(), description: '', ownerId: user!.uid,
//         isPrivate: true, isLocked: true, unlockAt: unlockAt, collaborators: _collaboratorUids,
//         coverImageUrl: '', createdAt: DateTime.now(), updatedAt: DateTime.now(),
//       ));
//
//       // 2. Save Note as a subcollection document
//       if (_noteController.text.isNotEmpty) {
//         await _capsuleService.addTextContent(capsuleId, _noteController.text, user.uid);
//       }
//
//       // 3. Loop and save EACH photo as a subcollection document
//       for (var file in _selectedMediaList) {
//         await _capsuleService.addMediaContent(capsuleId, file, user.uid);
//       }
//
//       if (mounted) Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//     } finally {
//       if (mounted) setState(() => _isSaving = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               colors: [AppColors.sunsetBlue, AppColors.sunsetOrange],
//               begin: Alignment.topCenter, end: Alignment.bottomCenter
//           )
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(backgroundColor: Colors.transparent, title: const Text('Create Capsule')),
//         body: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             _buildCard(TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title', labelStyle: TextStyle(color: Colors.white)))),
//             const SizedBox(height: 16),
//             _buildCard(ListTile(
//               title: const Text('Collaborators', style: TextStyle(color: Colors.white)),
//               subtitle: Text(_collaboratorNames.isEmpty ? 'None' : _collaboratorNames.join(', '), style: const TextStyle(color: Colors.white70)),
//               trailing: const Icon(Icons.person_add, color: Colors.orange),
//               onTap: () async {
//                 final res = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddCollaboratorsScreen()));
//                 if (res != null) setState(() {
//                   _collaboratorNames = res.map((e) => e['name']!).toList();
//                   _collaboratorUids = res.map((e) => e['uid']!).toList();
//                 });
//               },
//             )),
//             const SizedBox(height: 16),
//             _buildCard(ListTile(
//               title: const Text('Unlock Time', style: TextStyle(color: Colors.white)),
//               subtitle: Text(_selectedDate == null ? 'Not Set' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
//               onTap: () async {
//                 _selectedDate = await showDatePicker(context: context, initialDate: DateTime.now().add(const Duration(days: 1)), firstDate: DateTime.now(), lastDate: DateTime(2030));
//                 _selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
//                 setState(() {});
//               },
//             )),
//             const SizedBox(height: 16),
//             _buildCard(Column(children: [
//               TextField(controller: _noteController, maxLines: 3, decoration: const InputDecoration(hintText: 'Add a note...', hintStyle: TextStyle(color: Colors.white54))),
//               const SizedBox(height: 10),
//               Row(children: [
//                 ElevatedButton.icon(onPressed: _pickMedia, icon: const Icon(Icons.photo_library), label: const Text('Select Photos')),
//                 if (_selectedMediaList.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Text('(${_selectedMediaList.length})', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//                   ),
//               ]),
//             ])),
//             const SizedBox(height: 40),
//             ElevatedButton(
//                 onPressed: _isSaving ? null : _handleSealCapsule,
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.all(16)),
//                 child: _isSaving ? const CircularProgressIndicator(color: Colors.white) : const Text('Seal Capsule', style: TextStyle(color: Colors.white, fontSize: 18))
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard(Widget child) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(12)), child: child);
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lock_connect/core/constants/colors.dart';
import 'package:lock_connect/core/constants/app_colors.dart';
import '../../../lib/backend/services/cloudinary_config.dart';
import '../models/capsule.dart';
import '../services/capsule_service.dart';
import '../services/cloudinary_upload.dart';
import 'add_collaborators_screen.dart';

// --- DARK MODE CONSTANTS ---
const Color kAppBarForeground = Colors.white;
const Color kDarkCardBackground = Color(0xFF1E1E1E);

class CreateCapsuleScreen extends StatefulWidget {
  const CreateCapsuleScreen({super.key});
  @override
  State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
}

class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
  // --- CONTROLLERS & SERVICES ---
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  late final CapsuleService _capsuleService;

  // --- STATE VARIABLES ---
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<String> _collaboratorUids = [];
  List<String> _collaboratorNames = [];
  List<File> _selectedMediaList = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _capsuleService = CapsuleService(
      uploader: CloudinaryUploader(
        cloudName: CloudinaryConfig.cloudName,
        uploadPreset: CloudinaryConfig.uploadPreset,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickMedia() async {
    final picker = ImagePicker();
    final List<XFile> pickedList = await picker.pickMultiImage(imageQuality: 85);
    if (pickedList.isNotEmpty) {
      setState(() => _selectedMediaList = pickedList.map((f) => File(f.path)).toList());
    }
  }

  Future<void> _handleSealCapsule() async {
    if (_titleController.text.trim().isEmpty || _selectedDate == null) {
      _showSnackBar('Title and Date are required');
      return;
    }
    setState(() => _isSaving = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      final unlockAt = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, _selectedTime?.hour ?? 0, _selectedTime?.minute ?? 0);

      // 1. Create main capsule doc
      final capsuleId = await _capsuleService.createCapsule(Capsule(
        id: '', title: _titleController.text.trim(), description: '', ownerId: user!.uid,
        isPrivate: true, isLocked: true, unlockAt: unlockAt, collaborators: _collaboratorUids,
        coverImageUrl: '', createdAt: DateTime.now(), updatedAt: DateTime.now(),
      ));

      // 2. Save Note as a subcollection document
      if (_noteController.text.isNotEmpty) {
        await _capsuleService.addTextContent(capsuleId, _noteController.text, user.uid);
      }

      // 3. Loop and save EACH photo as a subcollection document
      for (var file in _selectedMediaList) {
        await _capsuleService.addMediaContent(capsuleId, file, user.uid);
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      _showSnackBar('Error: $e');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showSnackBar(String m, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m), backgroundColor: isError ? Colors.red : AppColors.sunsetPurple));
  }

  // Helper for structured, dark card container
  Widget _buildCardContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kDarkCardBackground.withOpacity(0.60),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Roboto');
    const inputTextStyle = TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Roboto');
    final hintTextStyle = TextStyle(color: Colors.white.withOpacity(0.5), fontFamily: 'Roboto');

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
              begin: Alignment.topCenter, end: Alignment.bottomCenter
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.goldText),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Create Capsule',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'PlayfairDisplay',
              color: AppColors.goldText,
              letterSpacing: 1,
              fontSize: 22,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // --- 1. TITLE SECTION ---
              _buildCardContainer(
                child: TextField(
                  controller: _titleController,
                  style: inputTextStyle,
                  decoration: InputDecoration(
                    labelText: 'Capsule Title', labelStyle: titleStyle,
                    hintText: 'e.g., Summer Memories', hintStyle: hintTextStyle,
                    border: InputBorder.none, suffixIcon: const Icon(Icons.lock, color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // --- 2. COLLABORATORS SECTION ---
              _buildCardContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Collaborators', style: titleStyle),
                          Text(_collaboratorNames.isEmpty ? 'None added' : _collaboratorNames.join(', '),
                              style: const TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'Roboto')),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_add, color: AppColors.sunsetOrange),
                      onPressed: () async {
                        final res = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddCollaboratorsScreen()));
                        if (res != null) setState(() {
                          _collaboratorNames = res.map((e) => e['name']!).toList();
                          _collaboratorUids = res.map((e) => e['uid']!).toList();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // --- 3. UNLOCK TIME SECTION ---
              _buildCardContainer(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Unlock Time', style: titleStyle),
                  subtitle: Text(
                    _selectedDate == null ? 'Not set' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    style: const TextStyle(color: AppColors.sunsetOrange, fontFamily: 'Roboto'),
                  ),
                  trailing: const Icon(Icons.calendar_today, color: AppColors.sunsetOrange),
                  onTap: () async {
                    final d = await showDatePicker(context: context, initialDate: DateTime.now().add(const Duration(days: 1)), firstDate: DateTime.now(), lastDate: DateTime(2030));
                    if (d != null) {
                      setState(() => _selectedDate = d);
                      final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if (t != null) setState(() => _selectedTime = t);
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),

              // --- 4. MEDIA & NOTE SECTION ---
              _buildCardContainer(
                child: Column(
                  children: [
                    TextField(
                      controller: _noteController,
                      maxLines: 4,
                      style: inputTextStyle,
                      decoration: InputDecoration(
                        hintText: 'Add a memory note...', hintStyle: hintTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickMedia,
                          icon: const Icon(Icons.photo_library, color: Colors.white),
                          label: const Text('Photos', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF303030)),
                        ),
                        if (_selectedMediaList.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text('(${_selectedMediaList.length} Selected)', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // --- 5. SEAL BUTTON ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _handleSealCapsule,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.sunsetOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Seal Capsule', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay')),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}