// // // // import 'dart:io';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:image_picker/image_picker.dart';
// // // // import '../models/capsule.dart';
// // // // import '../models/capsule_content.dart';
// // // // import '../services/capsule_service.dart';
// // // // import 'add_collaborators_screen.dart';
// // // // import 'package:lock_connect/utils/fallback_user.dart';
// // // //
// // // // class CapsuleDetailScreen extends StatefulWidget {
// // // //   final String capsuleId;
// // // //   final CapsuleService capsuleService;
// // // //   const CapsuleDetailScreen({
// // // //     super.key,
// // // //     required this.capsuleId,
// // // //     required this.capsuleService,
// // // //   });
// // // //
// // // //   @override
// // // //   State<CapsuleDetailScreen> createState() => _CapsuleDetailScreenState();
// // // // }
// // // //
// // // // class _CapsuleDetailScreenState extends State<CapsuleDetailScreen> {
// // // //   final _textCtrl = TextEditingController();
// // // //
// // // //   Future<void> _addText() async {
// // // //     final uid = currentUserIdOrFallback();
// // // //     if (_textCtrl.text.trim().isEmpty) return;
// // // //     await widget.capsuleService.addTextContent(widget.capsuleId, _textCtrl.text.trim(), uid: uid);
// // // //     _textCtrl.clear();
// // // //   }
// // // //
// // // //   Future<void> _addMedia(String type) async {
// // // //     final picker = ImagePicker();
// // // //     final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
// // // //     if (picked == null) return;
// // // //     final file = File(picked.path);
// // // //     final uid = currentUserIdOrFallback();
// // // //     await widget.capsuleService.addMediaContent(widget.capsuleId, file, type, uid: uid);
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final uid = currentUserIdOrFallback();
// // // //
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: const Text('Capsule Detail'),
// // // //         actions: [
// // // //           IconButton(
// // // //             icon: const Icon(Icons.group_add),
// // // //             onPressed: () => Navigator.push(
// // // //               context,
// // // //               MaterialPageRoute(
// // // //                 builder: (_) => AddCollaboratorsScreen(
// // // //                   capsuleId: widget.capsuleId,
// // // //                   capsuleService: widget.capsuleService,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       body: StreamBuilder<Capsule>(
// // // //         stream: widget.capsuleService.streamCapsule(widget.capsuleId),
// // // //         builder: (context, snap) {
// // // //           if (!snap.hasData) return const Center(child: CircularProgressIndicator());
// // // //           final capsule = snap.data!;
// // // //           final isOwner = capsule.ownerId == uid;
// // // //
// // // //           return Column(
// // // //             children: [
// // // //               ListTile(
// // // //                 title: Text(capsule.title),
// // // //                 subtitle: Text(capsule.description),
// // // //                 trailing: capsule.isPrivate ? const Icon(Icons.lock) : const Icon(Icons.public),
// // // //               ),
// // // //               Expanded(
// // // //                 child: StreamBuilder<List<CapsuleContent>>(
// // // //                   stream: widget.capsuleService.streamContents(widget.capsuleId),
// // // //                   builder: (context, snap2) {
// // // //                     if (!snap2.hasData) {
// // // //                       return const Center(child: CircularProgressIndicator());
// // // //                     }
// // // //                     final contents = snap2.data!;
// // // //                     if (contents.isEmpty) {
// // // //                       return const Center(child: Text('No content yet'));
// // // //                     }
// // // //                     return ListView.builder(
// // // //                       itemCount: contents.length,
// // // //                       itemBuilder: (_, i) {
// // // //                         final c = contents[i];
// // // //                         if (c.type == 'text') {
// // // //                           return ListTile(
// // // //                             title: Text(c.text ?? ''),
// // // //                             subtitle: Text('by ${c.createdBy}'),
// // // //                           );
// // // //                         } else {
// // // //                           return ListTile(
// // // //                             leading: c.type == 'image'
// // // //                                 ? Image.network(c.storagePath ?? '', width: 64, height: 64, fit: BoxFit.cover)
// // // //                                 : const Icon(Icons.videocam),
// // // //                             title: Text(c.type),
// // // //                             subtitle: Text('by ${c.createdBy}'),
// // // //                           );
// // // //                         }
// // // //                       },
// // // //                     );
// // // //                   },
// // // //                 ),
// // // //               ),
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(12),
// // // //                 child: Column(
// // // //                   children: [
// // // //                     Row(
// // // //                       children: [
// // // //                         Expanded(
// // // //                           child: TextField(
// // // //                             controller: _textCtrl,
// // // //                             decoration: const InputDecoration(labelText: 'Add text'),
// // // //                           ),
// // // //                         ),
// // // //                         IconButton(
// // // //                           icon: const Icon(Icons.send),
// // // //                           onPressed: _addText,
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                     Row(
// // // //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // //                       children: [
// // // //                         ElevatedButton.icon(
// // // //                           onPressed: () => _addMedia('image'),
// // // //                           icon: const Icon(Icons.image),
// // // //                           label: const Text('Add Image'),
// // // //                         ),
// // // //                         ElevatedButton.icon(
// // // //                           onPressed: () => _addMedia('image'), // change to 'video' if you add video upload endpoint
// // // //                           icon: const Icon(Icons.video_library),
// // // //                           label: const Text('Add Video'),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                     if (isOwner)
// // // //                       TextButton(
// // // //                         onPressed: () async {
// // // //                           await widget.capsuleService.deleteCapsule(widget.capsuleId);
// // // //                           if (mounted) Navigator.pop(context);
// // // //                         },
// // // //                         child: const Text('Delete capsule', style: TextStyle(color: Colors.red)),
// // // //                       ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // //
// // // import 'dart:io';
// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import '../models/capsule.dart';
// // // import '../models/capsule_content.dart';
// // // import '../services/capsule_service.dart';
// // // import 'add_collaborators_screen.dart';
// // //
// // // class CapsuleDetailScreen extends StatefulWidget {
// // //   final String capsuleId;
// // //   final CapsuleService capsuleService;
// // //   const CapsuleDetailScreen({
// // //     super.key,
// // //     required this.capsuleId,
// // //     required this.capsuleService,
// // //   });
// // //
// // //   @override
// // //   State<CapsuleDetailScreen> createState() => _CapsuleDetailScreenState();
// // // }
// // //
// // // class _CapsuleDetailScreenState extends State<CapsuleDetailScreen> {
// // //   final _textCtrl = TextEditingController();
// // //
// // //   Future<void> _addText() async {
// // //     final uid = FirebaseAuth.instance.currentUser!.uid;
// // //     if (_textCtrl.text.trim().isEmpty) return;
// // //     await widget.capsuleService.addTextContent(widget.capsuleId, _textCtrl.text.trim(), uid);
// // //     _textCtrl.clear();
// // //   }
// // //
// // //   Future<void> _addMedia(String type) async {
// // //     final picker = ImagePicker();
// // //     final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
// // //     if (picked == null) return;
// // //     final file = File(picked.path);
// // //     final uid = FirebaseAuth.instance.currentUser!.uid;
// // //     await widget.capsuleService.addMediaContent(widget.capsuleId, file, type, uid);
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final uid = FirebaseAuth.instance.currentUser!.uid;
// // //
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Capsule Detail'),
// // //         actions: [
// // //           IconButton(
// // //             icon: const Icon(Icons.group_add),
// // //             onPressed: () => Navigator.push(
// // //               context,
// // //               MaterialPageRoute(
// // //                 builder: (_) => AddCollaboratorsScreen(
// // //                   capsuleId: widget.capsuleId,
// // //                   capsuleService: widget.capsuleService,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       body: StreamBuilder<Capsule>(
// // //         stream: widget.capsuleService.streamCapsule(widget.capsuleId),
// // //         builder: (context, snap) {
// // //           if (!snap.hasData) return const Center(child: CircularProgressIndicator());
// // //           final capsule = snap.data!;
// // //           final isOwner = capsule.ownerId == uid;
// // //
// // //           return Column(
// // //             children: [
// // //               ListTile(
// // //                 title: Text(capsule.title),
// // //                 subtitle: Text(capsule.description),
// // //                 trailing: capsule.isPrivate ? const Icon(Icons.lock) : const Icon(Icons.public),
// // //               ),
// // //               Expanded(
// // //                 child: StreamBuilder<List<CapsuleContent>>(
// // //                   stream: widget.capsuleService.streamContents(widget.capsuleId),
// // //                   builder: (context, snap2) {
// // //                     if (!snap2.hasData) {
// // //                       return const Center(child: CircularProgressIndicator());
// // //                     }
// // //                     final contents = snap2.data!;
// // //                     if (contents.isEmpty) {
// // //                       return const Center(child: Text('No content yet'));
// // //                     }
// // //                     return ListView.builder(
// // //                       itemCount: contents.length,
// // //                       itemBuilder: (_, i) {
// // //                         final c = contents[i];
// // //                         if (c.type == 'text') {
// // //                           return ListTile(
// // //                             title: Text(c.text ?? ''),
// // //                             subtitle: Text('by ${c.createdBy}'),
// // //                           );
// // //                         } else {
// // //                           return ListTile(
// // //                             leading: c.type == 'image'
// // //                                 ? Image.network(c.storagePath ?? '', width: 64, height: 64, fit: BoxFit.cover)
// // //                                 : const Icon(Icons.videocam),
// // //                             title: Text(c.type),
// // //                             subtitle: Text('by ${c.createdBy}'),
// // //                           );
// // //                         }
// // //                       },
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //               Padding(
// // //                 padding: const EdgeInsets.all(12),
// // //                 child: Column(
// // //                   children: [
// // //                     Row(
// // //                       children: [
// // //                         Expanded(
// // //                           child: TextField(
// // //                             controller: _textCtrl,
// // //                             decoration: const InputDecoration(labelText: 'Add text'),
// // //                           ),
// // //                         ),
// // //                         IconButton(
// // //                           icon: const Icon(Icons.send),
// // //                           onPressed: _addText,
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     Row(
// // //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                       children: [
// // //                         ElevatedButton.icon(
// // //                           onPressed: () => _addMedia('image'),
// // //                           icon: const Icon(Icons.image),
// // //                           label: const Text('Add Image'),
// // //                         ),
// // //                         ElevatedButton.icon(
// // //                           onPressed: () => _addMedia('image'), // change to 'video' if you add video upload endpoint
// // //                           icon: const Icon(Icons.video_library),
// // //                           label: const Text('Add Video'),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     if (isOwner)
// // //                       TextButton(
// // //                         onPressed: () async {
// // //                           await widget.capsuleService.deleteCapsule(widget.capsuleId);
// // //                           if (mounted) Navigator.pop(context);
// // //                         },
// // //                         child: const Text('Delete capsule', style: TextStyle(color: Colors.red)),
// // //                       ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:lock_connect/core/constants/colors.dart';
// // import 'package:lock_connect/core/constants/app_colors.dart'; // Import AppColors for gradient/gold
// //
// // // --- DARK MODE OVERRIDES (Ensure consistency) ---
// // const Color kAppBackground = Color(0xFF121212);
// // const Color kAppBarForeground = Colors.white;
// // const Color kDarkCardBackground = Color(0xFF1E1E1E);
// //
// // class CapsuleDetailScreen extends StatelessWidget {
// //   final bool isLocked;
// //   final String capsuleTitle;
// //   final String creationDate;
// //   final String unlocksIn;
// //   final List<String> mockMediaUrls;
// //   final String mockNotes;
// //
// //   const CapsuleDetailScreen({
// //     super.key,
// //     this.isLocked = false,
// //     required this.capsuleTitle,
// //     required this.creationDate,
// //     required this.unlocksIn,
// //     // Increased mock media for better scroll view demonstration
// //     this.mockMediaUrls = const ['p1', 'p2', 'p3', 'p4', 'p5'],
// //     // Simulated 150-word note
// //     this.mockNotes = 'This capsule was opened to reveal memories from our incredible trip! We included five photos and a short video summarizing the best moments. This note serves as the official caption, documenting our thoughts and feelings upon seeing this content again after so long. It\'s truly amazing how quickly time passes, but these digitized moments keep the past vibrant and close. We hope future versions of ourselves continue to add to this archive of friendship and shared experiences!',
// //   });
// //
// //   // Helper to build a clean card container
// //   Widget _buildInfoCard({required Widget child}) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(16),
// //       margin: const EdgeInsets.only(bottom: 12),
// //       decoration: BoxDecoration(
// //         color: kDarkCardBackground.withOpacity(0.60), // Use opacity for cards
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: child,
// //     );
// //   }
// //
// //   // Helper to build a media placeholder item
// //   Widget _buildMediaItem(BuildContext context, int index) {
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     bool isVideo = index % 2 == 0;
// //
// //     return Container(
// //       width: screenWidth, // FULL WIDTH for Instagram post style
// //       margin: EdgeInsets.zero,
// //       decoration: const BoxDecoration(
// //         color: Color(0xFF303030),
// //       ),
// //       child: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             // FONT: Roboto
// //             Icon(isVideo ? Icons.videocam : Icons.photo, size: 80, color: kInactiveColor),
// //             Text(isVideo ? 'Video Clip' : 'High-Res Photo', style: const TextStyle(color: kInactiveColor, fontSize: 16, fontFamily: 'Roboto')),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // --- WRAP THE ENTIRE SCREEN IN THE GRADIENT CONTAINER ---
// //     return Container(
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [
// //             AppColors.sunsetBlue,
// //             AppColors.sunsetPurple,
// //             AppColors.sunsetPink,
// //             AppColors.sunsetOrange,
// //           ],
// //           begin: Alignment.topCenter,
// //           end: Alignment.bottomCenter,
// //         ),
// //       ),
// //       child: Scaffold(
// //         backgroundColor: Colors.transparent, // Scaffold transparent
// //         appBar: AppBar(
// //           backgroundColor: Colors.transparent, // AppBar transparent
// //           foregroundColor: kAppBarForeground,
// //           elevation: 0,
// //           iconTheme: const IconThemeData(color: AppColors.goldText),
// //
// //           title: Text(
// //             capsuleTitle,
// //             // --- APPLIED CAPSULE HOME SCREEN TITLE STYLING ---
// //             style: Theme.of(context).textTheme.titleLarge!.copyWith(
// //               fontWeight: FontWeight.bold,
// //               fontFamily: 'PlayfairDisplay',
// //               color: AppColors.goldText, // Gold for branding
// //               letterSpacing: 1,
// //               fontSize: 20, // Matches Capsule Home Screen
// //
// //             ),
// //           ),
// //
// //           // actions: [
// //           //   IconButton(icon: const Icon(Icons.share_outlined, color: kAppBarForeground), onPressed: () {}),
// //           // ],
// //         ),
// //         // appBar: AppBar(
// //         //   backgroundColor: Colors.transparent, // AppBar transparent
// //         //   foregroundColor: kAppBarForeground,
// //         //   elevation: 0,
// //         //   title: Text(
// //         //     capsuleTitle,
// //         //     // --- APPLIED CAPSULE HOME SCREEN TITLE STYLING ---
// //         //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
// //         //       fontWeight: FontWeight.bold,
// //         //       fontFamily: 'PlayfairDisplay',
// //         //       color: AppColors.goldText, // Gold for branding
// //         //       letterSpacing: 1,
// //         //       fontSize: 24,
// //         //     ),
// //         //     // --- MODIFIED LINES FOR WRAPPING ---
// //         //     maxLines: 2,
// //         //     overflow: TextOverflow.ellipsis,
// //         //   ),
// //         //   actions: [
// //         //     IconButton(icon: const Icon(Icons.share_outlined, color: kAppBarForeground), onPressed: () {}),
// //         //   ],
// //         // ),
// //         body: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // --- 1. HORIZONTAL MEDIA GALLERY (Instagram-style scroll) ---
// //             SizedBox(
// //               height: 350, // Large, fixed height for media viewing
// //               child: ListView.builder(
// //                 scrollDirection: Axis.horizontal,
// //                 itemCount: mockMediaUrls.length,
// //                 itemBuilder: (context, index) => _buildMediaItem(context, index), // Call helper
// //               ),
// //             ),
// //
// //             // --- 2. Scrollable Detail Content ---
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // --- Info & Dates ---
// //                     _buildInfoCard(
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// //                             const Text('Created On', style: TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Roboto')), // FONT: Roboto
// //                             Text(creationDate, style: const TextStyle(color: kAppBarForeground, fontWeight: FontWeight.bold, fontFamily: 'Roboto')), // FONT: Roboto
// //                           ]),
// //                           Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
// //                             const Text('Unlocked On', style: TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Roboto')), // FONT: Roboto
// //                             Text(unlocksIn, style: const TextStyle(color: kPrimaryAccentColor, fontWeight: FontWeight.bold, fontFamily: 'Roboto')), // FONT: Roboto
// //                           ]),
// //                         ],
// //                       ),
// //                     ),
// //
// //                     // --- Display Tiny NOTES (The caption) ---
// //                     Text(
// //                         'Note:',
// //                         style: Theme.of(context).textTheme.titleMedium!.copyWith(
// //                             color: kAppBarForeground,
// //                             fontWeight: FontWeight.bold,
// //                             fontFamily: 'Roboto' // FONT: Roboto
// //                         )
// //                     ),
// //                     _buildInfoCard(
// //                       child: Text(mockNotes, style: const TextStyle(color: kAppBarForeground, height: 1.5, fontFamily: 'Roboto')), // FONT: Roboto
// //                     ),
// //                     const SizedBox(height: 10),
// //
// //                     // --- Collaborators Section ---
// //                     Text(
// //                         'Collaborators:',
// //                         // style: Theme.of(context).textTheme.titleLarge!.copyWith(
// //                         //     color: kAppBarForeground,
// //                         //     fontWeight: FontWeight.bold,
// //                         //     fontFamily: 'Roboto' // FONT: Roboto
// //                         style: Theme.of(context).textTheme.titleLarge!.copyWith(
// //                           fontWeight: FontWeight.bold,
// //                           fontFamily: 'PlayfairDisplay',
// //                           color: AppColors.goldText, // Gold for branding
// //                           letterSpacing: 1,
// //                           fontSize: 18,
// //                         )
// //                     ),
// //                     const SizedBox(height: 10),
// //                     _buildMockCollaboratorList(),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // Helper function to build a mock collaborator list
// //   Widget _buildMockCollaboratorList() {
// //     return Column(
// //       children: [
// //         _buildAvatarStackItem('Alex Johnson'),
// //         _buildAvatarStackItem('Sarah Lee'),
// //         _buildAvatarStackItem('Mike Chen'),
// //       ],
// //     );
// //   }
// //
// //   // Simple avatar placeholder
// //   Widget _buildAvatarStackItem(String name) {
// //     return _buildInfoCard(
// //         child: Row(
// //           children: [
// //             CircleAvatar(
// //               backgroundColor: kPrimaryAccentColor,
// //               radius: 18,
// //               child: Text(name[0], style: const TextStyle(color: Colors.black, fontFamily: 'Roboto')), // FONT: Roboto
// //             ),
// //             const SizedBox(width: 10),
// //             Text(name, style: const TextStyle(color: kAppBarForeground, fontSize: 16, fontFamily: 'Roboto')), // FONT: Roboto
// //           ],
// //         )
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:lock_connect/core/constants/colors.dart';
// import 'package:lock_connect/core/constants/app_colors.dart';
// import '../models/capsule.dart';
// import '../services/capsule_service.dart';
//
// // --- DARK MODE OVERRIDES ---
// const Color kAppBarForeground = Colors.white;
// const Color kDarkCardBackground = Color(0xFF1E1E1E);
//
//   class CapsuleDetailScreen extends StatelessWidget {
//   final String capsuleId; // Added this
//   final CapsuleService capsuleService; // Added this
//
//   const CapsuleDetailScreen({
//   super.key,
//   required this.capsuleId,
//   required this.capsuleService,
//   });
//
//   Widget _buildInfoCard({required Widget child}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: kDarkCardBackground.withOpacity(0.60),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: child,
//     );
//   }
//
//   Widget _buildMediaItem(BuildContext context, Map<String, dynamic> content) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final String type = content['type'] ?? 'image';
//     final String url = content['mediaUrl'] ?? '';
//
//     return Container(
//       width: screenWidth,
//       decoration: const BoxDecoration(color: Color(0xFF121212)),
//       child: url.isNotEmpty
//           ? Image.network(
//         url,
//         fit: BoxFit.cover,
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) return child;
//           return const Center(child: CircularProgressIndicator(color: AppColors.sunsetOrange));
//         },
//         errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.white24, size: 50),
//       )
//           : Center(child: Icon(type == 'video' ? Icons.videocam : Icons.photo, size: 80, color: kInactiveColor)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<Capsule>(
//       stream: capsuleService.streamCapsule(capsuleId),
//       builder: (context, capsuleSnap) {
//         if (!capsuleSnap.hasData) return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator()));
//
//         final capsule = capsuleSnap.data!;
//         final String dateStr = capsule.createdAt != null ? "${capsule.createdAt!.month}/${capsule.createdAt!.day}/${capsule.createdAt!.year}" : "--";
//         final String unlockStr = capsule.unlockAt != null ? "${capsule.unlockAt!.month}/${capsule.unlockAt!.day}/${capsule.unlockAt!.year}" : "Unlocked";
//
//         return Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: AppBar(
//               backgroundColor: Colors.transparent,
//               foregroundColor: kAppBarForeground,
//               elevation: 0,
//               iconTheme: const IconThemeData(color: AppColors.goldText),
//               title: Text(
//                 capsule.title,
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'PlayfairDisplay',
//                   color: AppColors.goldText,
//                   letterSpacing: 1,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             body: StreamBuilder<List<Map<String, dynamic>>>(
//               // FIX: Calling streamContents and ensuring it matches the expected type
//               stream: capsuleService.streamContents(capsuleId),
//               builder: (context, contentSnap) {
//                 // Cast the data or provide an empty list to avoid errors on line 626
//                 final List<Map<String, dynamic>> contents = contentSnap.data ?? [];
//
//                 final mediaItems = contents.where((c) => c['type'] == 'image' || c['type'] == 'video').toList();
//                 final noteItems = contents.where((c) => c['type'] == 'text').toList();
//
//                 final String noteText = noteItems.isNotEmpty ? noteItems.first['text'] : "No note added to this capsule.";
//
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 350,
//                       child: mediaItems.isEmpty
//                           ? Center(child: Text("No photos in this capsule", style: TextStyle(color: Colors.white.withOpacity(0.5))))
//                           : ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: mediaItems.length,
//                         itemBuilder: (context, index) => _buildMediaItem(context, mediaItems[index]),
//                       ),
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildInfoCard(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                                     const Text('Created On', style: TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Roboto')),
//                                     Text(dateStr, style: const TextStyle(color: kAppBarForeground, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
//                                   ]),
//                                   Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//                                     const Text('Unlocked On', style: TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Roboto')),
//                                     Text(unlockStr, style: const TextStyle(color: kPrimaryAccentColor, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
//                                   ]),
//                                 ],
//                               ),
//                             ),
//                             Text('Note:', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kAppBarForeground, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
//                             _buildInfoCard(
//                               child: Text(noteText, style: const TextStyle(color: kAppBarForeground, height: 1.5, fontFamily: 'Roboto')),
//                             ),
//                             const SizedBox(height: 10),
//                             Text('Collaborators:',
//                                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'PlayfairDisplay',
//                                   color: AppColors.goldText,
//                                   letterSpacing: 1,
//                                   fontSize: 18,
//                                 )),
//                             const SizedBox(height: 10),
//                             // FIX: Handling the list of collaborators
//                             ...capsule.collaborators.map((uid) => _buildCollaboratorItem(uid)).toList(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildCollaboratorItem(String uid) {
//     return _buildInfoCard(
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: kPrimaryAccentColor,
//               radius: 18,
//               child: const Icon(Icons.person, size: 18, color: Colors.black),
//             ),
//             const SizedBox(width: 10),
//             Text("Collaborator", style: const TextStyle(color: kAppBarForeground, fontSize: 16, fontFamily: 'Roboto')),
//           ],
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:lock_connect/core/constants/colors.dart';
import 'package:lock_connect/core/constants/app_colors.dart';
import '../models/capsule.dart';
import '../services/capsule_service.dart';

// --- DARK MODE OVERRIDES ---
const Color kAppBarForeground = Colors.white;
const Color kDarkCardBackground = Color(0xFF1E1E1E);

class CapsuleDetailScreen extends StatelessWidget {
  final String capsuleId;
  final CapsuleService capsuleService;

  const CapsuleDetailScreen({
    super.key,
    required this.capsuleId,
    required this.capsuleService,
  });

  Widget _buildInfoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kDarkCardBackground.withOpacity(0.60),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  // UPDATED: Builds real media from Cloudinary URLs found in Firebase
  Widget _buildMediaItem(BuildContext context, Map<String, dynamic> content) {
    final screenWidth = MediaQuery.of(context).size.width;
    final String url = content['mediaUrl'] ?? '';
    final String type = content['type'] ?? 'image';

    return Container(
      width: screenWidth,
      decoration: const BoxDecoration(color: Color(0xFF121212)),
      child: url.isNotEmpty
          ? Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator(color: AppColors.sunsetOrange));
        },
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.white24, size: 50),
      )
          : Center(child: Icon(type == 'video' ? Icons.videocam : Icons.photo, size: 80, color: kInactiveColor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Capsule>(
      stream: capsuleService.streamCapsule(capsuleId),
      builder: (context, capsuleSnap) {
        if (!capsuleSnap.hasData) return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator()));

        final capsule = capsuleSnap.data!;
        final String dateStr = capsule.createdAt != null
            ? "${capsule.createdAt!.month}/${capsule.createdAt!.day}/${capsule.createdAt!.year}"
            : "--/--/----";
        final String unlockStr = capsule.unlockAt != null
            ? "${capsule.unlockAt!.month}/${capsule.unlockAt!.day}/${capsule.unlockAt!.year}"
            : "Opened";

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
              backgroundColor: Colors.transparent,
              foregroundColor: kAppBarForeground,
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.goldText),
              title: Text(
                capsule.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  color: AppColors.goldText,
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
            ),
            body: StreamBuilder<List<Map<String, dynamic>>>(
              stream: capsuleService.streamContents(capsuleId),
              builder: (context, contentSnap) {
                final contents = contentSnap.data ?? [];

                // Separate media from text notes
                final mediaItems = contents.where((c) => c['type'] == 'image' || c['type'] == 'video').toList();
                final noteItems = contents.where((c) => c['type'] == 'text').toList();
                final String noteText = noteItems.isNotEmpty ? noteItems.first['text'] : "No note attached.";

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- 1. HORIZONTAL MEDIA GALLERY (Real Data) ---
                    SizedBox(
                      height: 350,
                      child: mediaItems.isEmpty
                          ? const Center(child: Text("No photos in this capsule", style: TextStyle(color: Colors.white54)))
                          : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mediaItems.length,
                        itemBuilder: (context, index) => _buildMediaItem(context, mediaItems[index]),
                      ),
                    ),

                    // --- 2. Scrollable Detail Content ---
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoCard(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    const Text('Created On', style: TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Roboto')),
                                    Text(dateStr, style: const TextStyle(color: kAppBarForeground, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
                                  ]),
                                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                    const Text('Unlocked On', style: TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Roboto')),
                                    Text(unlockStr, style: const TextStyle(color: kPrimaryAccentColor, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
                                  ]),
                                ],
                              ),
                            ),

                            Text('Note:', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kAppBarForeground, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
                            _buildInfoCard(
                              child: Text(noteText, style: const TextStyle(color: kAppBarForeground, height: 1.5, fontFamily: 'Roboto')),
                            ),
                            const SizedBox(height: 10),

                            Text('Collaborators:',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PlayfairDisplay',
                                  color: AppColors.goldText,
                                  letterSpacing: 1,
                                  fontSize: 18,
                                )
                            ),
                            const SizedBox(height: 10),

                            // Display real collaborator UIDs (Mapping names requires extra user lookup)
                            ...capsule.collaborators.map((uid) => _buildCollaboratorItem(uid)).toList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCollaboratorItem(String uid) {
    return _buildInfoCard(
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: kPrimaryAccentColor,
              radius: 18,
              child: const Icon(Icons.person, size: 18, color: Colors.black),
            ),
            const SizedBox(width: 10),
            Text("User ID: ${uid.substring(0, 5)}...", style: const TextStyle(color: kAppBarForeground, fontSize: 14, fontFamily: 'Roboto')),
          ],
        )
    );
  }
}