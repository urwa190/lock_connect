// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:image_picker/image_picker.dart'; // IMPORT YOUR NEW CONFIG
// // import '../../../lib/backend/services/cloudinary_config.dart';
// // import '../models/capsule.dart';
// // import '../services/capsule_service.dart';
// // import '../services/cloudinary_upload.dart';
// //
// // class CreateCapsuleScreen extends StatefulWidget {
// //   const CreateCapsuleScreen({super.key});
// //
// //   @override
// //   State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
// // }
// //
// // class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
// //   final _titleCtrl = TextEditingController();
// //   final _noteCtrl = TextEditingController();
// //   late final CapsuleService _capsuleService; // USE LATE INITIALIZATION
// //
// //   File? _mediaFile;
// //   DateTime? _selectedDate;
// //   TimeOfDay? _selectedTime;
// //   bool _isSaving = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // INITIALIZE WITH YOUR CONFIG CLASS
// //     _capsuleService = CapsuleService(
// //       uploader: CloudinaryUploader(
// //         cloudName: CloudinaryConfig.cloudName,
// //         uploadPreset: CloudinaryConfig.uploadPreset,
// //       ),
// //     );
// //   }
// //
// //   Future<void> _handleSeal() async {
// //     if (_titleCtrl.text.isEmpty || _selectedDate == null) return;
// //     setState(() => _isSaving = true);
// //
// //     try {
// //       final user = FirebaseAuth.instance.currentUser;
// //       final unlockDate = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, _selectedTime?.hour ?? 0, _selectedTime?.minute ?? 0);
// //
// //       final capsule = Capsule(
// //         id: '',
// //         title: _titleCtrl.text,
// //         description: _noteCtrl.text,
// //         ownerId: user!.uid,
// //         isPrivate: true,
// //         isLocked: true,
// //         unlockAt: unlockDate,
// //         coverImageUrl: '',
// //         collaborators: [],
// //         createdAt: DateTime.now(),
// //         updatedAt: DateTime.now(), // THIS NOW WORKS
// //       );
// //
// //       final id = await _capsuleService.createCapsule(capsule, coverFile: _mediaFile);
// //       if (_noteCtrl.text.isNotEmpty) {
// //         await _capsuleService.addTextContent(id, _noteCtrl.text, user.uid);
// //       }
// //       Navigator.pop(context);
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
// //     } finally {
// //       setState(() => _isSaving = false);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('New Capsule')),
// //       body: _isSaving
// //           ? const Center(child: CircularProgressIndicator())
// //           : ListView(
// //         padding: const EdgeInsets.all(16),
// //         children: [
// //           TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
// //           const SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: () async {
// //               _selectedDate = await showDatePicker(context: context, initialDate: DateTime.now().add(const Duration(days: 1)), firstDate: DateTime.now(), lastDate: DateTime(2030));
// //               _selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
// //               setState(() {});
// //             },
// //             child: Text(_selectedDate == null ? 'Set Unlock Time' : 'Unlocks on: $_selectedDate'),
// //           ),
// //           const SizedBox(height: 20),
// //           TextField(controller: _noteCtrl, maxLines: 3, decoration: const InputDecoration(labelText: 'Memory Note')),
// //           const SizedBox(height: 20),
// //           ElevatedButton.icon(
// //             onPressed: () async {
// //               final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
// //               if (picked != null) setState(() => _mediaFile = File(picked.path));
// //             },
// //             icon: const Icon(Icons.image),
// //             label: Text(_mediaFile == null ? 'Add Photo' : 'Photo Attached'),
// //           ),
// //           const SizedBox(height: 40),
// //           ElevatedButton(onPressed: _handleSeal, child: const Text('Seal Capsule')),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lock_connect/core/constants/colors.dart';
// import 'package:lock_connect/core/constants/app_colors.dart';
//
// // Import your internal project files
// import '../../../lib/backend/services/cloudinary_config.dart';
// import '../models/capsule.dart';
// import '../services/capsule_service.dart';
// import '../services/cloudinary_upload.dart';
// import 'add_collaborators_screen.dart';
//
// // --- DARK MODE CONSTANTS ---
// const Color kAppBarForeground = Colors.white;
// const Color kDarkCardBackground = Color(0xFF1E1E1E);
//
// class CreateCapsuleScreen extends StatefulWidget {
//   const CreateCapsuleScreen({super.key});
//
//   @override
//   State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
// }
//
// class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
//   // --- CONTROLLERS & SERVICES ---
//   final _titleController = TextEditingController();
//   final _noteController = TextEditingController();
//   late final CapsuleService _capsuleService;
//
//   // --- STATE VARIABLES ---
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   List<String> _collaborators = [];
//   File? _selectedMedia;
//   bool _isSaving = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize service using your centralized config
//     _capsuleService = CapsuleService(
//       uploader: CloudinaryUploader(
//         cloudName: CloudinaryConfig.cloudName,
//         uploadPreset: CloudinaryConfig.uploadPreset,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _noteController.dispose();
//     super.dispose();
//   }
//
//   // --- PICKER LOGIC ---
//   Future<void> _pickMedia() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
//     if (picked != null) {
//       setState(() => _selectedMedia = File(picked.path));
//       _showSnackBar('Media selected!', isError: false);
//     }
//   }
//
//   Future<void> _selectDate() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now().add(const Duration(days: 1)),
//       firstDate: DateTime.now().add(const Duration(days: 1)),
//       lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
//       builder: (context, child) => Theme(
//         data: ThemeData.dark().copyWith(
//           colorScheme: ColorScheme.dark(
//             primary: AppColors.sunsetOrange,
//             surface: kDarkCardBackground,
//           ),
//         ),
//         child: child!,
//       ),
//     );
//
//     if (pickedDate != null) {
//       setState(() => _selectedDate = pickedDate);
//       _selectTime();
//     }
//   }
//
//   Future<void> _selectTime() async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//       builder: (context, child) => Theme(
//         data: ThemeData.dark().copyWith(
//           colorScheme: ColorScheme.dark(primary: AppColors.sunsetOrange),
//         ),
//         child: child!,
//       ),
//     );
//
//     if (pickedTime != null) {
//       setState(() => _selectedTime = pickedTime);
//     }
//   }
//
//   // --- BACKEND LOGIC ---
//   Future<void> _handleSealCapsule() async {
//     if (_titleController.text.trim().isEmpty || _selectedDate == null) {
//       _showSnackBar('Title and Unlock Date are required');
//       return;
//     }
//
//     setState(() => _isSaving = true);
//
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       final unlockDateTime = DateTime(
//         _selectedDate!.year, _selectedDate!.month, _selectedDate!.day,
//         _selectedTime?.hour ?? 0, _selectedTime?.minute ?? 0,
//       );
//
//       final capsule = Capsule(
//         id: '',
//         title: _titleController.text.trim(),
//         description: '',
//         ownerId: user!.uid,
//         isPrivate: true,
//         isLocked: true,
//         unlockAt: unlockDateTime,
//         collaborators: _collaborators,
//         coverImageUrl: '',
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//       );
//
//       // Create capsule and upload to Cloudinary
//       final capsuleId = await _capsuleService.createCapsule(capsule, coverFile: _selectedMedia);
//
//       // Add the text note to subcollection
//       if (_noteController.text.trim().isNotEmpty) {
//         await _capsuleService.addTextContent(capsuleId, _noteController.text.trim(), user.uid);
//       }
//
//       if (mounted) {
//         _showSnackBar('New capsule created!', isError: false);
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       _showSnackBar('Error: ${e.toString()}');
//     } finally {
//       if (mounted) setState(() => _isSaving = false);
//     }
//   }
//
//   void _showSnackBar(String message, {bool isError = true}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message, style: const TextStyle(fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: isError ? Colors.red : AppColors.sunsetPurple,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }
//
//   // --- UI HELPERS ---
//   Widget _buildCardContainer({required Widget child, EdgeInsets? padding}) {
//     return Container(
//       width: double.infinity,
//       padding: padding ?? const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: kDarkCardBackground.withOpacity(0.60),
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       child: child,
//     );
//   }
//
//   Widget _buildMediaButton(IconData icon, String label) {
//     return GestureDetector(
//       onTap: _pickMedia,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF303030),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: AppColors.sunsetOrange, size: 20),
//             const SizedBox(width: 8),
//             Text(label, style: TextStyle(color: AppColors.sunsetOrange, fontFamily: 'Roboto')),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final TextStyle cardTitleStyle = const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Roboto');
//     final TextStyle inputTextStyle = const TextStyle(color: kAppBarForeground, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Roboto');
//     final TextStyle hintTextStyle = TextStyle(color: kInactiveColor.withOpacity(0.5), fontFamily: 'Roboto');
//
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           foregroundColor: kAppBarForeground,
//           title: Text(
//             'Create Capsule',
//             style: Theme.of(context).textTheme.titleLarge!.copyWith(
//               fontWeight: FontWeight.bold,
//               fontFamily: 'PlayfairDisplay',
//               color: AppColors.goldText,
//               letterSpacing: 1,
//               fontSize: 22,
//             ),
//           ),
//           iconTheme: const IconThemeData(color: AppColors.goldText),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildCardContainer(
//                 child: TextField(
//                   controller: _titleController,
//                   decoration: InputDecoration(
//                     labelText: 'Capsule Title',
//                     labelStyle: cardTitleStyle,
//                     hintText: 'e.g., Trip to Kyoto Memories',
//                     hintStyle: hintTextStyle,
//                     border: InputBorder.none,
//                     suffixIcon: const Icon(Icons.lock_rounded, size: 20, color: Colors.white70),
//                   ),
//                   style: inputTextStyle,
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               _buildCardContainer(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Add Collaborators', style: cardTitleStyle),
//                     const SizedBox(height: 12),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             ..._collaborators.take(3).map((name) => Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: CircleAvatar(
//                                 radius: 18,
//                                 backgroundColor: AppColors.sunsetOrange,
//                                 child: Text(name[0], style: const TextStyle(color: Colors.white)),
//                               ),
//                             )).toList(),
//                             if (_collaborators.length > 3)
//                               Text('+${_collaborators.length - 3} more', style: const TextStyle(color: Colors.white70)),
//                             if (_collaborators.isEmpty)
//                               const Icon(Icons.group_add, color: Colors.white54, size: 24),
//                           ],
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.arrow_forward_ios, color: AppColors.sunsetOrange, size: 16),
//                           onPressed: () async {
//                             final result = await Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const AddCollaboratorsScreen()),
//                             );
//                             if (result != null && result is List<String>) {
//                               setState(() => _collaborators = result);
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               _buildCardContainer(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Set Unlock Time', style: cardTitleStyle),
//                     const SizedBox(height: 8),
//                     TextButton.icon(
//                       onPressed: _selectDate,
//                       icon: Icon(Icons.calendar_month, color: AppColors.sunsetOrange),
//                       label: Text(
//                         _selectedDate == null || _selectedTime == null
//                             ? 'Select Date and Time'
//                             : '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year} ${_selectedTime!.format(context)}',
//                         style: TextStyle(color: AppColors.sunsetOrange, fontSize: 16, fontFamily: 'Roboto'),
//                       ),
//                       style: TextButton.styleFrom(alignment: Alignment.centerLeft, padding: EdgeInsets.zero),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               _buildCardContainer(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Media & Note', style: cardTitleStyle),
//                     const SizedBox(height: 12),
//                     TextField(
//                       controller: _noteController,
//                       maxLines: 4,
//                       decoration: InputDecoration(
//                         hintText: 'Add a tiny note to rekindle your memories...',
//                         hintStyle: hintTextStyle,
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
//                         filled: true,
//                         fillColor: const Color(0xFF303030).withOpacity(0.60),
//                       ),
//                       style: inputTextStyle,
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         _buildMediaButton(Icons.photo, 'Photos'),
//                         const SizedBox(width: 10),
//                         _buildMediaButton(Icons.videocam, 'Videos'),
//                         if (_selectedMedia != null)
//                           const Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Icon(Icons.check_circle, color: Colors.green, size: 20),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 40),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _isSaving ? null : _handleSealCapsule,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     backgroundColor: AppColors.sunsetOrange,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                     elevation: 8,
//                   ),
//                   child: _isSaving
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text('Seal Capsule', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay')),
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lock_connect/core/constants/colors.dart';
import 'package:lock_connect/core/constants/app_colors.dart';

// Internal project imports
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

  // Stores names for UI and UIDs for Firebase
  List<String> _collaboratorNames = [];
  List<String> _collaboratorUids = [];

  File? _selectedMedia;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Initialized with your CloudinaryConfig class
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

  // --- LOGIC METHODS ---

  Future<void> _pickMedia() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) {
      setState(() => _selectedMedia = File(picked.path));
      _showSnackBar('Media attached!', isError: false);
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
      _selectTime();
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) setState(() => _selectedTime = pickedTime);
  }

  void _navigateToAddCollaborators() async {
    // Result comes back as List<Map<String, String>> from your new screen
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCollaboratorsScreen()),
    );

    if (result != null && result is List<Map<String, String>>) {
      setState(() {
        _collaboratorNames = result.map((e) => e['name']!).toList();
        _collaboratorUids = result.map((e) => e['uid']!).toList();
      });
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
      final unlockDateTime = DateTime(
        _selectedDate!.year, _selectedDate!.month, _selectedDate!.day,
        _selectedTime?.hour ?? 0, _selectedTime?.minute ?? 0,
      );

      // 1. Create Capsule Main Document
      final capsule = Capsule(
        id: '',
        title: _titleController.text.trim(),
        description: '',
        ownerId: user!.uid,
        isPrivate: true,
        isLocked: true,
        unlockAt: unlockDateTime,
        collaborators: _collaboratorUids, // Saving real UIDs for security rules
        coverImageUrl: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(), // Field now enabled in your model
      );

      final capsuleId = await _capsuleService.createCapsule(capsule, coverFile: _selectedMedia);

      // 2. Create Content Subcollection for the note
      if (_noteController.text.trim().isNotEmpty) {
        await _capsuleService.addTextContent(capsuleId, _noteController.text.trim(), user.uid);
      }

      if (mounted) {
        _showSnackBar('New capsule created!', isError: false);
        Navigator.pop(context);
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: isError ? Colors.red : AppColors.sunsetPurple,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // --- UI BUILDING ---

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

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent, elevation: 0,
          title: Text('Create Capsule', style: TextStyle(fontFamily: 'PlayfairDisplay', color: AppColors.goldText, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCardContainer(
                child: TextField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Capsule Title', labelStyle: titleStyle,
                    hintText: 'e.g., Summer Memories', hintStyle: TextStyle(color: Colors.white30),
                    border: InputBorder.none, suffixIcon: const Icon(Icons.lock, color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildCardContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Collaborators', style: titleStyle),
                        Text(_collaboratorNames.isEmpty ? 'None added' : _collaboratorNames.join(', '),
                            style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                    IconButton(icon: const Icon(Icons.person_add, color: AppColors.sunsetOrange), onPressed: _navigateToAddCollaborators),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildCardContainer(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Unlock Time', style: titleStyle),
                  subtitle: Text(_selectedDate == null ? 'Not set' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                  trailing: const Icon(Icons.calendar_today, color: AppColors.sunsetOrange),
                  onTap: _selectDate,
                ),
              ),
              const SizedBox(height: 16),
              _buildCardContainer(
                child: Column(
                  children: [
                    TextField(
                      controller: _noteController, maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(hintText: 'Add a memory note...', hintStyle: TextStyle(color: Colors.white30), border: InputBorder.none),
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(onPressed: _pickMedia, icon: const Icon(Icons.image), label: const Text('Photos')),
                        if (_selectedMedia != null) const Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _handleSealCapsule,
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.sunsetOrange, padding: const EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  child: _isSaving ? const CircularProgressIndicator(color: Colors.white) : const Text('Seal Capsule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}