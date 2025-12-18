// // // // import 'package:flutter/material.dart';
// // // // import 'dart:math' as math;
// // // // import 'package:lock_connect/core/constants/colors.dart'; // Contains kPrimaryAccentColor, kLockedCapsuleBase, etc.
// // // // import 'package:lock_connect/core/constants/app_colors.dart'; // Contains AppColors.sunsetBlue, AppColors.goldText, etc.
// // // // import '../widgets/visual_capsule_card.dart'; // The card for the list items
// // // // import 'create_capsule_screen.dart'; // Screen 14 for the FAB navigation
// // // // import 'capsule_detail_screen.dart'; // Screen 16 for unlocked capsule navigation
// // // //
// // // // // --- NEW IMPORT ---
// // // // import 'collaborations_request_screen.dart'; // Screen for managing requests
// // // // // --------------------
// // // //
// // // // class CapsuleHomeScreen extends StatefulWidget {
// // // //   const CapsuleHomeScreen({super.key});
// // // //
// // // //   @override
// // // //   State<CapsuleHomeScreen> createState() => _CapsuleHomeScreenState();
// // // // }
// // // //
// // // // class _CapsuleHomeScreenState extends State<CapsuleHomeScreen> {
// // // //   String selectedTab = 'Active';
// // // //
// // // //   // FINAL DATA SOURCE: Includes 'unlocksIn' field for Click Logic
// // // //   final List<Map<String, dynamic>> allCapsules = const [
// // // //     {'title': 'Summer Trip Memories \'24', 'isLocked': true, 'creationDate': '10/15/2025', 'unlocksIn': '12 Days, 4 Hours'},
// // // //     {'title': 'Graduation Day Archive', 'isLocked': false, 'creationDate': '05/20/2025', 'unlocksIn': 'Opened'},
// // // //     {'title': 'Family Vacation 2023', 'isLocked': true, 'creationDate': '07/01/2025', 'unlocksIn': '90 Days, 1 Hour'},
// // // //     {'title': 'Holiday Party Photos', 'isLocked': false, 'creationDate': '12/10/2024', 'unlocksIn': 'Opened'},
// // // //     {'title': 'Work Project Launch', 'isLocked': true, 'creationDate': '09/05/2025', 'unlocksIn': '30 Days, 18 Hours'},
// // // //   ];
// // // //
// // // //   // --- Click Logic Handler (Custom Dialog or Navigation) ---
// // // //   void _handleCardTap(BuildContext context, Map<String, dynamic> capsule) {
// // // //     if (capsule['isLocked'] == true) {
// // // //       // --- LOCKED ACTION: Show Custom Countdown Dialog ---
// // // //       showDialog(
// // // //         context: context,
// // // //         builder: (BuildContext dialogContext) {
// // // //           return AlertDialog(
// // // //             backgroundColor: const Color(0xFF1E1E1E), // Dark background for dialog
// // // //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // // //             title: Center(
// // // //                 child: Text(
// // // //                     'Capsule Sealed',
// // // //                     style: TextStyle(
// // // //                       color: kPrimaryAccentColor,
// // // //                       fontWeight: FontWeight.w300,
// // // //                     )
// // // //                 )
// // // //             ),
// // // //             content: Column(
// // // //               mainAxisSize: MainAxisSize.min,
// // // //               children: [
// // // //                 const Icon(Icons.lock_rounded, size: 52, color: Colors.white),
// // // //                 const SizedBox(height: 20),
// // // //                 const Text(
// // // //                     'Unlocks in:',
// // // //                     style: TextStyle(
// // // //                       color: Colors.white70,
// // // //                       fontSize: 14,
// // // //                       fontFamily: 'Roboto', // Explicitly set the font to Roboto
// // // //                     )
// // // //                 ),
// // // //                 Text(
// // // //                     capsule['unlocksIn']!,
// // // //                     style: const TextStyle(
// // // //                       color: Colors.white,
// // // //                       fontSize: 18,
// // // //                       fontWeight: FontWeight.w400,
// // // //                       fontFamily: 'Roboto', // Explicitly set the font to Roboto
// // // //                     )
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //             actions: [
// // // //               TextButton(
// // // //                 onPressed: () => Navigator.of(dialogContext).pop(),
// // // //                 child: const Text(
// // // //                     'OK',
// // // //                     style: TextStyle(
// // // //                       color: kPrimaryAccentColor,
// // // //                       fontFamily: 'Roboto', // Explicitly set the font to Roboto
// // // //                     )
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           );
// // // //         },
// // // //       );
// // // //     } else {
// // // //       // --- UNLOCKED ACTION: Navigate to Capsule Details Screen (Screen 16) ---
// // // //       Navigator.push(
// // // //         context,
// // // //         MaterialPageRoute(
// // // //           builder: (context) => CapsuleDetailScreen(
// // // //             capsuleTitle: capsule['title']!,
// // // //             isLocked: false,
// // // //             creationDate: capsule['creationDate']!,
// // // //             unlocksIn: capsule['unlocksIn']!,
// // // //             mockMediaUrls: const ['url1', 'url2'],
// // // //             mockNotes: 'A delightful note from collaborators.',
// // // //           ),
// // // //         ),
// // // //       );
// // // //     }
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     // WRAP the entire Scaffold in a Container with the gradient for seamless background
// // // //     return Container(
// // // //       decoration: const BoxDecoration(
// // // //         gradient: LinearGradient(
// // // //           colors: [
// // // //             AppColors.sunsetBlue,
// // // //             AppColors.sunsetPurple,
// // // //             AppColors.sunsetPink,
// // // //             AppColors.sunsetOrange,
// // // //           ],
// // // //           begin: Alignment.topCenter,
// // // //           end: Alignment.bottomCenter,
// // // //         ),
// // // //       ),
// // // //       child: Scaffold(
// // // //         // Set Scaffold and AppBar backgrounds to transparent so the gradient shows through
// // // //         backgroundColor: Colors.transparent,
// // // //         appBar: AppBar(
// // // //           backgroundColor: Colors.transparent,
// // // //           foregroundColor: Colors.white, // White icons/text
// // // //           elevation: 0,
// // // //
// // // //           automaticallyImplyLeading: false,
// // // //           title: Row(
// // // //             children: [
// // // //               // 1. TILTED CAPSULE ICON
// // // //               Padding(
// // // //                 padding: const EdgeInsets.only(right: 0.1),
// // // //                 child: Transform.rotate(
// // // //                   angle: 0.6, // Tilted anti-clockwise
// // // //                   child: Image(
// // // //                     image: const AssetImage('assets/images/capsule.png'),
// // // //                     fit: BoxFit.contain,
// // // //                     width: 40,
// // // //                     height: 40,
// // // //                     filterQuality: FilterQuality.high,
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //
// // // //               // 3. CUSTOM STYLING FOR "Capsules" TEXT
// // // //               Text(
// // // //                   'Capsules',
// // // //                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
// // // //                     fontWeight: FontWeight.bold,
// // // //                     fontFamily: 'PlayfairDisplay',
// // // //                     color: AppColors.goldText,
// // // //                     letterSpacing: 1,
// // // //                     fontSize: 22,
// // // //                   )
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           actions: [
// // // //             IconButton(
// // // //               icon: const Icon(Icons.person_add_alt_1_outlined, color: Colors.white),
// // // //               onPressed: () {
// // // //                 // --- IMPLEMENTED NAVIGATION TO REQUESTS SCREEN ---
// // // //                 Navigator.push(
// // // //                   context,
// // // //                   MaterialPageRoute(builder: (context) => const CollaborationRequestsScreen()),
// // // //                 );
// // // //               },
// // // //             ),
// // // //             const SizedBox(width: 10),
// // // //           ],
// // // //         ),
// // // //
// // // //         body: ListView(
// // // //           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// // // //           children: [
// // // //             _buildFilterTabs(),
// // // //             const SizedBox(height: 20),
// // // //             _buildFilteredList(selectedTab),
// // // //           ],
// // // //         ),
// // // //
// // // //         floatingActionButton: FloatingActionButton(
// // // //           backgroundColor: AppColors.sunsetOrange,
// // // //           onPressed: () {
// // // //             Navigator.push(
// // // //               context,
// // // //               MaterialPageRoute(builder: (context) => const CreateCapsuleScreen()),
// // // //             );
// // // //           },
// // // //           child: const Icon(Icons.add, color: Colors.white),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // --- Helper: Tab Styling and Logic ---
// // // //   Widget _buildFilterTabs() {
// // // //     return Row(
// // // //       children: ['Active', 'Locked', 'Unlocked'].map((tab) {
// // // //         bool isSelected = selectedTab == tab;
// // // //         return Padding(
// // // //           padding: const EdgeInsets.only(right: 12.0),
// // // //           child: GestureDetector(
// // // //             onTap: () {
// // // //               setState(() {
// // // //                 selectedTab = tab;
// // // //               });
// // // //             },
// // // //             child: Container(
// // // //               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
// // // //               decoration: BoxDecoration(
// // // //                 // Use Sunset Orange for selected tab
// // // //                 color: isSelected ? AppColors.sunsetOrange : const Color(0xFF303030),
// // // //
// // // //                 borderRadius: BorderRadius.circular(30),
// // // //               ),
// // // //               child: Text(
// // // //                   tab,
// // // //                   style: const TextStyle(
// // // //                     color: Colors.white,
// // // //                     fontWeight: FontWeight.w600,
// // // //                     fontFamily: 'Roboto',
// // // //                   )
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         );
// // // //       }).toList(),
// // // //     );
// // // //   }
// // // //
// // // //   // --- Helper: Filtering and Card Generation ---
// // // //   Widget _buildFilteredList(String tab) {
// // // //     List filteredList;
// // // //
// // // //     if (tab == 'Locked') {
// // // //       filteredList = allCapsules.where((c) => c['isLocked'] == true).toList();
// // // //     } else if (tab == 'Unlocked') {
// // // //       filteredList = allCapsules.where((c) => c['isLocked'] == false).toList();
// // // //     } else {
// // // //       filteredList = allCapsules;
// // // //     }
// // // //
// // // //     return Column(
// // // //       children: filteredList.map((capsule) {
// // // //         bool isLocked = capsule['isLocked'] as bool;
// // // //         String creationDate = capsule['creationDate'] as String;
// // // //
// // // //         // Base color for the capsule card gradient tint
// // // //         Color color = isLocked ? kLockedCapsuleBase : kUnlockedCapsuleBase;
// // // //
// // // //         return VisualCapsuleCard(
// // // //           title: capsule['title']!,
// // // //           baseColor: color,
// // // //           isLocked: isLocked,
// // // //           creationDate: creationDate,
// // // //           onTap: () => _handleCardTap(context, capsule),
// // // //         );
// // // //       }).toList(),
// // // //     );
// // // //   }
// // // // }
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import '../models/capsule.dart';
// // // import '../services/capsule_service.dart';
// // // import '../services/cloudinary_upload.dart';
// // // import 'capsule_detail_screen.dart';
// // // import 'create_capsule_screen.dart';
// // // import '../widgets/visual_capsule_card.dart';
// // //
// // // class CapsuleHomeScreen extends StatelessWidget {
// // //   CapsuleHomeScreen({super.key});
// // //
// // //   // Set your Cloudinary config here
// // //   final _capsuleService = CapsuleService(
// // //     uploader: CloudinaryUploader(
// // //       cloudName: "dl484kobd",
// // //       uploadPreset: "unsigned_preset",
// // //     ),
// // //   );
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final uid = FirebaseAuth.instance.currentUser!.uid;
// // //
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text('Capsules')),
// // //       body: StreamBuilder<List<Capsule>>(
// // //         stream: _capsuleService.streamCapsulesForUser(uid),
// // //         builder: (context, snap) {
// // //           if (snap.connectionState == ConnectionState.waiting) {
// // //             return const Center(child: CircularProgressIndicator());
// // //           }
// // //           if (snap.hasError) {
// // //             return Center(child: Text('Error: ${snap.error}'));
// // //           }
// // //           final capsules = snap.data ?? [];
// // //           if (capsules.isEmpty) {
// // //             return const Center(child: Text('No capsules yet.'));
// // //           }
// // //           return ListView.builder(
// // //             itemCount: capsules.length,
// // //             itemBuilder: (_, i) => GestureDetector(
// // //               onTap: () => Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(
// // //                   builder: (_) => CapsuleDetailScreen(
// // //                     capsuleId: capsules[i].id,
// // //                     capsuleService: _capsuleService,
// // //                   ),
// // //                 ),
// // //               ),
// // //               child: VisualCapsuleCard(capsule: capsules[i]),
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: () => Navigator.push(
// // //           context,
// // //           MaterialPageRoute(
// // //             builder: (_) => CreateCapsuleScreen(capsuleService: _capsuleService),
// // //           ),
// // //         ),
// // //         child: const Icon(Icons.add),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // import 'package:flutter/material.dart';
// // import '../models/capsule.dart';
// // import '../services/capsule_service.dart';
// // import '../services/cloudinary_upload.dart';
// // import 'capsule_detail_screen.dart';
// // import 'create_capsule_screen.dart';
// // import '../widgets/visual_capsule_card.dart';
// // import 'package:lock_connect/utils/fallback_user.dart';
// //
// // class CapsuleHomeScreen extends StatelessWidget {
// //   CapsuleHomeScreen({super.key});
// //
// //   // Set your Cloudinary config here
// //   final _capsuleService = CapsuleService(
// //     uploader: CloudinaryUploader(
// //       cloudName: "dl484kobd",
// //       uploadPreset: "unsigned_preset",
// //     ),
// //   );
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final uid = currentUserIdOrFallback();
// //
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Capsules')),
// //       body: StreamBuilder<List<Capsule>>(
// //         stream: _capsuleService.streamCapsulesForUser(uid),
// //         builder: (context, snap) {
// //           if (snap.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //           if (snap.hasError) {
// //             return Center(child: Text('Error: ${snap.error}'));
// //           }
// //           final capsules = snap.data ?? [];
// //           if (capsules.isEmpty) {
// //             return const Center(child: Text('No capsules yet.'));
// //           }
// //           return ListView.builder(
// //             itemCount: capsules.length,
// //             itemBuilder: (_, i) => GestureDetector(
// //               onTap: () => Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (_) => CapsuleDetailScreen(
// //                     capsuleId: capsules[i].id,
// //                     capsuleService: _capsuleService,
// //                   ),
// //                 ),
// //               ),
// //               child: VisualCapsuleCard(capsule: capsules[i]),
// //             ),
// //           );
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () => Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (_) => CreateCapsuleScreen(capsuleService: _capsuleService),
// //           ),
// //         ),
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/capsule.dart';
// import '../services/capsule_service.dart';
// import '../services/cloudinary_upload.dart';
// import 'capsule_detail_screen.dart';
// import 'create_capsule_screen.dart';
// import '../widgets/visual_capsule_card.dart';
//
// class CapsuleHomeScreen extends StatelessWidget {
//   CapsuleHomeScreen({super.key});
//
//   // Set your Cloudinary config here
//   final _capsuleService = CapsuleService(
//     uploader: CloudinaryUploader(
//       cloudName: 'dl484kobd"',
//       uploadPreset: 'unsigned_preset',
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Capsules')),
//       body: StreamBuilder<List<Capsule>>(
//         stream: _capsuleService.streamCapsulesForUser(uid),
//         builder: (context, snap) {
//           if (snap.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snap.hasError) {
//             return Center(child: Text('Error: ${snap.error}'));
//           }
//           final capsules = snap.data ?? [];
//           if (capsules.isEmpty) {
//             return const Center(child: Text('No capsules yet.'));
//           }
//           return ListView.builder(
//             itemCount: capsules.length,
//             itemBuilder: (_, i) => GestureDetector(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => CapsuleDetailScreen(
//                     capsuleId: capsules[i].id,
//                     capsuleService: _capsuleService,
//                   ),
//                 ),
//               ),
//               child: VisualCapsuleCard(capsule: capsules[i]),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => CreateCapsuleScreen(capsuleService: _capsuleService),
//           ),
//         ),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:lock_connect/core/constants/colors.dart'; // Contains kPrimaryAccentColor, kLockedCapsuleBase, etc.
import 'package:lock_connect/core/constants/app_colors.dart'; // Contains AppColors.sunsetBlue, AppColors.goldText, etc.
import '../widgets/visual_capsule_card.dart'; // The card for the list items
import 'create_capsule_screen.dart'; // Screen 14 for the FAB navigation
import 'capsule_detail_screen.dart'; // Screen 16 for unlocked capsule navigation

// --- NEW IMPORT ---
import 'collaborations_request_screen.dart'; // Screen for managing requests
// --------------------

class CapsuleHomeScreen extends StatefulWidget {
  const CapsuleHomeScreen({super.key});

  @override
  State<CapsuleHomeScreen> createState() => _CapsuleHomeScreenState();
}

class _CapsuleHomeScreenState extends State<CapsuleHomeScreen> {
  String selectedTab = 'Active';

  // FINAL DATA SOURCE: Includes 'unlocksIn' field for Click Logic
  final List<Map<String, dynamic>> allCapsules = const [
    {'title': 'Summer Trip Memories \'24', 'isLocked': true, 'creationDate': '10/15/2025', 'unlocksIn': '12 Days, 4 Hours'},
    {'title': 'Graduation Day Archive', 'isLocked': false, 'creationDate': '05/20/2025', 'unlocksIn': 'Opened'},
    {'title': 'Family Vacation 2023', 'isLocked': true, 'creationDate': '07/01/2025', 'unlocksIn': '90 Days, 1 Hour'},
    {'title': 'Holiday Party Photos', 'isLocked': false, 'creationDate': '12/10/2024', 'unlocksIn': 'Opened'},
    {'title': 'Work Project Launch', 'isLocked': true, 'creationDate': '09/05/2025', 'unlocksIn': '30 Days, 18 Hours'},
  ];

  // --- Click Logic Handler (Custom Dialog or Navigation) ---
  void _handleCardTap(BuildContext context, Map<String, dynamic> capsule) {
    if (capsule['isLocked'] == true) {
      // --- LOCKED ACTION: Show Custom Countdown Dialog ---
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E), // Dark background for dialog
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Center(
                child: Text(
                    'Capsule Sealed',
                    style: TextStyle(
                      color: kPrimaryAccentColor,
                      fontWeight: FontWeight.w300,
                    )
                )
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_rounded, size: 52, color: Colors.white),
                const SizedBox(height: 20),
                const Text(
                    'Unlocks in:',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'Roboto', // Explicitly set the font to Roboto
                    )
                ),
                Text(
                    capsule['unlocksIn']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto', // Explicitly set the font to Roboto
                    )
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text(
                    'OK',
                    style: TextStyle(
                      color: kPrimaryAccentColor,
                      fontFamily: 'Roboto', // Explicitly set the font to Roboto
                    )
                ),
              ),
            ],
          );
        },
      );
    } else {
      // --- UNLOCKED ACTION: Navigate to Capsule Details Screen (Screen 16) ---
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CapsuleDetailScreen(
            capsuleTitle: capsule['title']!,
            isLocked: false,
            creationDate: capsule['creationDate']!,
            unlocksIn: capsule['unlocksIn']!,
            mockMediaUrls: const ['url1', 'url2'],
            mockNotes: 'A delightful note from collaborators.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // WRAP the entire Scaffold in a Container with the gradient for seamless background
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.sunsetBlue,
            AppColors.sunsetPurple,
            AppColors.sunsetPink,
            AppColors.sunsetOrange,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        // Set Scaffold and AppBar backgrounds to transparent so the gradient shows through
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white, // White icons/text
          elevation: 0,

          automaticallyImplyLeading: false,
          title: Row(
            children: [
              // 1. TILTED CAPSULE ICON
              Padding(
                padding: const EdgeInsets.only(right: 0.1),
                child: Transform.rotate(
                  angle: 0.6, // Tilted anti-clockwise
                  child: Image(
                    image: const AssetImage('assets/images/capsule.png'),
                    fit: BoxFit.contain,
                    width: 40,
                    height: 40,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),

              // 3. CUSTOM STYLING FOR "Capsules" TEXT
              Text(
                  'Capsules',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                    color: AppColors.goldText,
                    letterSpacing: 1,
                    fontSize: 22,
                  )
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add_alt_1_outlined, color: Colors.white),
              onPressed: () {
                // --- IMPLEMENTED NAVIGATION TO REQUESTS SCREEN ---
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CollaborationRequestsScreen()),
                );
              },
            ),
            const SizedBox(width: 10),
          ],
        ),

        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: [
            _buildFilterTabs(),
            const SizedBox(height: 20),
            _buildFilteredList(selectedTab),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.sunsetOrange,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateCapsuleScreen()),
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  // --- Helper: Tab Styling and Logic ---
  Widget _buildFilterTabs() {
    return Row(
      children: ['Active', 'Locked', 'Unlocked'].map((tab) {
        bool isSelected = selectedTab == tab;
        return Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = tab;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                // Use Sunset Orange for selected tab
                color: isSelected ? AppColors.sunsetOrange : const Color(0xFF303030),

                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                  tab,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                  )
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // --- Helper: Filtering and Card Generation ---
  Widget _buildFilteredList(String tab) {
    List filteredList;

    if (tab == 'Locked') {
      filteredList = allCapsules.where((c) => c['isLocked'] == true).toList();
    } else if (tab == 'Unlocked') {
      filteredList = allCapsules.where((c) => c['isLocked'] == false).toList();
    } else {
      filteredList = allCapsules;
    }

    return Column(
      children: filteredList.map((capsule) {
        bool isLocked = capsule['isLocked'] as bool;
        String creationDate = capsule['creationDate'] as String;

        // Base color for the capsule card gradient tint
        Color color = isLocked ? kLockedCapsuleBase : kUnlockedCapsuleBase;

        return VisualCapsuleCard(
          title: capsule['title']!,
          baseColor: color,
          isLocked: isLocked,
          creationDate: creationDate,
          onTap: () => _handleCardTap(context, capsule),
        );
      }).toList(),
    );
  }
}