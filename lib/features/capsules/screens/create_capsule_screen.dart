// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:lock_connect/core/constants/colors.dart';
// // // import 'package:lock_connect/core/constants/app_colors.dart';
// // // import 'add_collaborators_screen.dart'; // Import Screen 15
// // //
// // //
// // // // --- DARK MODE CONSTANTS ---
// // // const Color kAppBarForeground = Colors.white;
// // // const Color kDarkCardBackground = Color(0xFF1E1E1E);
// // //
// // // class CreateCapsuleScreen extends StatefulWidget {
// // //   const CreateCapsuleScreen({super.key});
// // //
// // //   @override
// // //   State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
// // // }
// // //
// // // class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
// // //   // --- STATE VARIABLES ---
// // //   DateTime? _selectedDate;
// // //   TimeOfDay? _selectedTime;
// // //   List<String> _collaborators = []; // NEW: State to hold selected collaborator names
// // //
// // //   // --- DATE/TIME PICKER LOGIC ---
// // //   Future<void> _selectDate() async {
// // //     final DateTime? pickedDate = await showDatePicker(
// // //       context: context,
// // //       initialDate: DateTime.now().add(const Duration(days: 1)),
// // //       firstDate: DateTime.now().add(const Duration(days: 1)),
// // //       lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
// // //       builder: (context, child) {
// // //         return Theme(
// // //           data: ThemeData.dark().copyWith(
// // //             colorScheme: ColorScheme.dark(
// // //               primary: AppColors.sunsetOrange,
// // //               onPrimary: Colors.white,
// // //               surface: kDarkCardBackground,
// // //               onSurface: Colors.white,
// // //             ),
// // //             dialogBackgroundColor: kDarkCardBackground,
// // //           ),
// // //           child: child!,
// // //         );
// // //       },
// // //     );
// // //
// // //     if (pickedDate != null) {
// // //       setState(() {
// // //         _selectedDate = pickedDate;
// // //       });
// // //       _selectTime();
// // //     }
// // //   }
// // //
// // //   Future<void> _selectTime() async {
// // //     final TimeOfDay? pickedTime = await showTimePicker(
// // //       context: context,
// // //       initialTime: TimeOfDay.now(),
// // //       builder: (context, child) {
// // //         return Theme(
// // //           data: ThemeData.dark().copyWith(
// // //             colorScheme: ColorScheme.dark(
// // //               primary: AppColors.sunsetOrange,
// // //               onPrimary: Colors.white,
// // //               surface: kDarkCardBackground,
// // //               onSurface: Colors.white,
// // //             ),
// // //             dialogBackgroundColor: kDarkCardBackground,
// // //           ),
// // //           child: child!,
// // //         );
// // //       },
// // //     );
// // //
// // //     if (pickedTime != null) {
// // //       setState(() {
// // //         _selectedTime = pickedTime;
// // //       });
// // //     }
// // //   }
// // //
// // //   // --- COLLABORATOR NAVIGATION LOGIC ---
// // //   void _navigateToAddCollaborators() async {
// // //     final result = await Navigator.push(
// // //       context,
// // //       MaterialPageRoute(builder: (context) => const AddCollaboratorsScreen()),
// // //     );
// // //
// // //     // Update state with the returned list of collaborators
// // //     if (result != null && result is List<String>) {
// // //       setState(() {
// // //         _collaborators = result;
// // //       });
// // //     }
// // //   }
// // //
// // //   // Helper for structured, dark card container used for form sections
// // //   Widget _buildCardContainer({required Widget child, EdgeInsets? padding}) {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: padding ?? const EdgeInsets.all(16.0),
// // //       decoration: BoxDecoration(
// // //         color: kDarkCardBackground.withOpacity(0.60),
// // //         borderRadius: BorderRadius.circular(16.0),
// // //       ),
// // //       child: child,
// // //     );
// // //   }
// // //
// // //   // Helper for the ORANGE accent button at the bottom
// // //   Widget _buildNextStepButton() {
// // //     return SizedBox(
// // //       width: double.infinity,
// // //       child: ElevatedButton(
// // //         onPressed: () {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             SnackBar(
// // //               content: const Text(
// // //                 'New capsule created!',
// // //                 style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.bold),
// // //               ),
// // //               backgroundColor: AppColors.sunsetPurple,
// // //               duration: const Duration(seconds: 2),
// // //               behavior: SnackBarBehavior.floating,
// // //             ),
// // //           );
// // //         },
// // //         style: ElevatedButton.styleFrom(
// // //           padding: const EdgeInsets.symmetric(vertical: 16),
// // //           backgroundColor: AppColors.sunsetOrange,
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(30),
// // //           ),
// // //           elevation: 8,
// // //           shadowColor: AppColors.sunsetOrange.withOpacity(0.5),
// // //         ),
// // //         child: Text(
// // //           'Seal Capsule',
// // //           style: const TextStyle(
// // //             color: Colors.white,
// // //             fontSize: 18,
// // //             fontWeight: FontWeight.bold,
// // //             fontFamily: 'PlayfairDisplay',
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   // Helper for media buttons
// // //   Widget _buildMediaButton(IconData icon, String label) {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(
// // //             content: const Text(
// // //               'Gallery will be shown here',
// // //               style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.bold),
// // //             ),
// // //             backgroundColor: AppColors.sunsetPurple,
// // //             duration: const Duration(seconds: 2),
// // //             behavior: SnackBarBehavior.floating,
// // //           ),
// // //         );
// // //       },
// // //       child: Container(
// // //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // //         decoration: BoxDecoration(
// // //           color: const Color(0xFF303030),
// // //           borderRadius: BorderRadius.circular(20),
// // //         ),
// // //         child: Row(
// // //           children: [
// // //             Icon(icon, color: AppColors.sunsetOrange, size: 20),
// // //             const SizedBox(width: 8),
// // //             // FONT: Roboto
// // //             Text(label, style: TextStyle(color: AppColors.sunsetOrange, fontFamily: 'Roboto')),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // Defines the style for the card titles/labels to maintain consistency
// // //     final TextStyle cardTitleStyle = TextStyle(
// // //       color: Colors.white, // White labels
// // //       fontSize: 16,
// // //       fontWeight: FontWeight.bold,
// // //       fontFamily: 'Roboto',
// // //     );
// // //     // Defines the style for input text fields
// // //     final TextStyle inputTextStyle = const TextStyle(color: kAppBarForeground, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Roboto');
// // //     // Defines the style for hint text
// // //     final TextStyle hintTextStyle = TextStyle(color: kInactiveColor.withOpacity(0.5), fontFamily: 'Roboto');
// // //
// // //
// // //     return Container(
// // //       decoration: const BoxDecoration(
// // //         gradient: LinearGradient(
// // //           colors: [
// // //             AppColors.sunsetBlue,
// // //             AppColors.sunsetPurple,
// // //             AppColors.sunsetPink,
// // //             AppColors.sunsetOrange,
// // //           ],
// // //           begin: Alignment.topCenter,
// // //           end: Alignment.bottomCenter,
// // //         ),
// // //       ),
// // //       child: Scaffold(
// // //         backgroundColor: Colors.transparent,
// // //         appBar: AppBar(
// // //           backgroundColor: Colors.transparent,
// // //           elevation: 0,
// // //           foregroundColor: kAppBarForeground,
// // //
// // //           title: Text(
// // //             'Create Capsule',
// // //             style: Theme.of(context).textTheme.titleLarge!.copyWith(
// // //               fontWeight: FontWeight.bold,
// // //               fontFamily: 'PlayfairDisplay',
// // //               color: AppColors.goldText,
// // //               letterSpacing: 1,
// // //               fontSize: 22,
// // //             ),
// // //           ),
// // //           iconTheme: const IconThemeData(color: AppColors.goldText),
// // //         ),
// // //         body: SingleChildScrollView(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               // --- 1. TITLE SECTION (TextField) ---
// // //               _buildCardContainer(
// // //                 child: TextField(
// // //                   decoration: InputDecoration(
// // //                     labelText: 'Capsule Title',
// // //                     labelStyle: cardTitleStyle,
// // //                     hintText: 'e.g., Trip to Kyoto Memories',
// // //                     hintStyle: hintTextStyle,
// // //                     border: InputBorder.none,
// // //                     suffixIcon: const Icon(Icons.lock_rounded, size: 20, color: Colors.white70),
// // //                   ),
// // //                   style: inputTextStyle,
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 16),
// // //
// // //               // --- 2. COLLABORATORS SECTION (Navigation to Screen 15) ---
// // //               _buildCardContainer(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text('Add Collaborators', style: cardTitleStyle),
// // //                     const SizedBox(height: 12),
// // //
// // //                     Row(
// // //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                       children: [
// // //                         // Display selected collaborators
// // //                         Row(
// // //                           children: [
// // //                             ..._collaborators.take(3).map((name) =>
// // //                                 Padding(
// // //                                   padding: const EdgeInsets.only(right: 8.0),
// // //                                   child: CircleAvatar(
// // //                                     radius: 18,
// // //                                     backgroundColor: AppColors.sunsetOrange,
// // //                                     child: Text(name[0], style: const TextStyle(color: Colors.white, fontFamily: 'Roboto')),
// // //                                   ),
// // //                                 ),
// // //                             ).toList(),
// // //
// // //                             // Display count if more than 3
// // //                             if (_collaborators.length > 3)
// // //                               Text('+${_collaborators.length - 3} more', style: const TextStyle(color: Colors.white70, fontFamily: 'Roboto')),
// // //
// // //                             // Placeholder if no collaborators
// // //                             if (_collaborators.isEmpty)
// // //                               const Icon(Icons.group_add, color: Colors.white54, size: 24),
// // //                           ],
// // //                         ),
// // //
// // //                         IconButton(
// // //                           icon: Icon(Icons.arrow_forward_ios, color: AppColors.sunsetOrange, size: 16),
// // //                           onPressed: _navigateToAddCollaborators, // <--- CALLS NAVIGATOR
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 16),
// // //
// // //               // --- 3. UNLOCK DATE SECTION (Date Picker Placeholder) ---
// // //               _buildCardContainer(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text('Set Unlock Time', style: cardTitleStyle),
// // //                     const SizedBox(height: 8),
// // //
// // //                     TextButton.icon(
// // //                       onPressed: _selectedDate == null || _selectedTime == null ? _selectDate : null,
// // //                       icon: Icon(Icons.calendar_month, color: AppColors.sunsetOrange),
// // //                       label: Text(
// // //                           _selectedDate == null || _selectedTime == null
// // //                               ? 'Select Date and Time'
// // //                               : '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year} ${_selectedTime!.format(context)}',
// // //                           style: TextStyle(
// // //                               color: AppColors.sunsetOrange,
// // //                               fontSize: 16,
// // //                               fontFamily: 'Roboto'
// // //                           )
// // //                       ),
// // //                       style: TextButton.styleFrom(alignment: Alignment.centerLeft, padding: EdgeInsets.zero),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 16),
// // //
// // //               // --- 4. ADD MEDIA/NOTES SECTION ---
// // //               _buildCardContainer(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text('Media & Note', style: cardTitleStyle),
// // //                     const SizedBox(height: 12),
// // //
// // //                     // Text Note Input
// // //                     TextField(
// // //                       maxLines: 4,
// // //                       decoration: InputDecoration(
// // //                         hintText: 'Add a tiny note to rekinl your memories in the future...',
// // //                         hintStyle: hintTextStyle,
// // //                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
// // //                         filled: true,
// // //                         fillColor: const Color(0xFF303030).withOpacity(0.60),
// // //                       ),
// // //                       style: inputTextStyle,
// // //                     ),
// // //                     const SizedBox(height: 12),
// // //
// // //                     // Media Buttons
// // //                     Row(
// // //                       children: [
// // //                         _buildMediaButton(Icons.photo, 'Photos'),
// // //                         const SizedBox(width: 10),
// // //                         _buildMediaButton(Icons.videocam, 'Videos'),
// // //                       ],
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 40),
// // //
// // //               // --- 5. SEAL CAPSULE BUTTON ---
// // //               _buildNextStepButton(),
// // //               const SizedBox(height: 20),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:image_picker/image_picker.dart';
// // import '../models/capsule.dart';
// // import '../services/capsule_service.dart';
// // import 'capsule_detail_screen.dart';
// //
// // class CreateCapsuleScreen extends StatefulWidget {
// //   final CapsuleService capsuleService;
// //   const CreateCapsuleScreen({super.key, required this.capsuleService});
// //
// //   @override
// //   State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
// // }
// //
// // class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _titleCtrl = TextEditingController();
// //   final _descCtrl = TextEditingController();
// //   bool _isPrivate = false;
// //   File? _coverFile;
// //   bool _saving = false;
// //
// //   Future<void> _pickCover() async {
// //     final picker = ImagePicker();
// //     final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
// //     if (picked != null) setState(() => _coverFile = File(picked.path));
// //   }
// //
// //   Future<void> _create() async {
// //     if (!_formKey.currentState!.validate()) return;
// //     setState(() => _saving = true);
// //     final uid = FirebaseAuth.instance.currentUser!.uid;
// //     final capsule = Capsule(
// //       id: '',
// //       title: _titleCtrl.text.trim(),
// //       description: _descCtrl.text.trim(),
// //       ownerId: uid,
// //       isPrivate: _isPrivate,
// //       coverImageUrl: '',
// //       collaborators: const [],
// //       createdAt: DateTime.now(),
// //       updatedAt: DateTime.now(),
// //     );
// //     try {
// //       final id = await widget.capsuleService.createCapsule(capsule, coverFile: _coverFile);
// //       if (!mounted) return;
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(
// //           builder: (_) => CapsuleDetailScreen(
// //             capsuleId: id,
// //             capsuleService: widget.capsuleService,
// //           ),
// //         ),
// //       );
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
// //     } finally {
// //       if (mounted) setState(() => _saving = false);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Create Capsule')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Form(
// //           key: _formKey,
// //           child: ListView(
// //             children: [
// //               TextFormField(
// //                 controller: _titleCtrl,
// //                 decoration: const InputDecoration(labelText: 'Title'),
// //                 validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
// //               ),
// //               const SizedBox(height: 12),
// //               TextFormField(
// //                 controller: _descCtrl,
// //                 decoration: const InputDecoration(labelText: 'Description'),
// //                 maxLines: 3,
// //               ),
// //               SwitchListTile(
// //                 value: _isPrivate,
// //                 onChanged: (v) => setState(() => _isPrivate = v),
// //                 title: const Text('Private capsule'),
// //               ),
// //               const SizedBox(height: 12),
// //               Row(
// //                 children: [
// //                   ElevatedButton.icon(
// //                     onPressed: _pickCover,
// //                     icon: const Icon(Icons.image),
// //                     label: const Text('Pick cover'),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   if (_coverFile != null) const Text('Cover selected'),
// //                 ],
// //               ),
// //               const SizedBox(height: 24),
// //               ElevatedButton(
// //                 onPressed: _saving ? null : _create,
// //                 child: _saving
// //                     ? const CircularProgressIndicator.adaptive()
// //                     : const Text('Create'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../models/capsule.dart';
// import '../services/capsule_service.dart';
// import 'capsule_detail_screen.dart';
// import 'package:lock_connect/utils/fallback_user.dart'; // <-- added
//
// class CreateCapsuleScreen extends StatefulWidget {
//   final CapsuleService capsuleService;
//   const CreateCapsuleScreen({super.key, required this.capsuleService});
//
//   @override
//   State<CreateCapsuleScreen> createState() => _CreateCapsuleScreenState();
// }
//
// class _CreateCapsuleScreenState extends State<CreateCapsuleScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleCtrl = TextEditingController();
//   final _descCtrl = TextEditingController();
//   bool _isPrivate = false;
//   File? _coverFile;
//   bool _saving = false;
//
//   Future<void> _pickCover() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
//     if (picked != null) setState(() => _coverFile = File(picked.path));
//   }
//
//   Future<void> _create() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _saving = true);
//
//     final uid = currentUserIdOrFallback(); // <-- fallback-aware
//
//     final capsule = Capsule(
//       id: '',
//       title: _titleCtrl.text.trim(),
//       description: _descCtrl.text.trim(),
//       ownerId: uid,
//       isPrivate: _isPrivate,
//       coverImageUrl: '',
//       collaborators: const [],
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//     );
//     try {
//       final id = await widget.capsuleService.createCapsule(capsule, coverFile: _coverFile);
//       if (!mounted) return;
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => CapsuleDetailScreen(
//             capsuleId: id,
//             capsuleService: widget.capsuleService,
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//     } finally {
//       if (mounted) setState(() => _saving = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Create Capsule')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _titleCtrl,
//                 decoration: const InputDecoration(labelText: 'Title'),
//                 validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _descCtrl,
//                 decoration: const InputDecoration(labelText: 'Description'),
//                 maxLines: 3,
//               ),
//               SwitchListTile(
//                 value: _isPrivate,
//                 onChanged: (v) => setState(() => _isPrivate = v),
//                 title: const Text('Private capsule'),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: _pickCover,
//                     icon: const Icon(Icons.image),
//                     label: const Text('Pick cover'),
//                   ),
//                   const SizedBox(width: 12),
//                   if (_coverFile != null) const Text('Cover selected'),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _saving ? null : _create,
//                 child: _saving
//                     ? const CircularProgressIndicator.adaptive()
//                     : const Text('Create'),
//               ),
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
import '../models/capsule.dart';
import '../services/capsule_service.dart';
import 'capsule_detail_screen.dart';

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

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be signed in to create a capsule.')),
      );
      return;
    }

    setState(() => _saving = true);
    final uid = user.uid;
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