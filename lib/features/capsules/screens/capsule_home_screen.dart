// import 'package:flutter/material.dart';
// import 'package:lock_connect/core/constants/colors.dart';
// import '../widgets/visual_capsule_card.dart';
// import 'create_capsule_screen.dart';
// import 'capsule_detail_screen.dart'; // Needed for navigation
//
// // --- DARK MODE OVERRIDES ---
// const Color kAppBackground = Color(0xFF121212); // Deep Black Background
// const Color kAppBarForeground = Colors.white; // White icons/text on dark background
//
// class CapsuleHomeScreen extends StatefulWidget {
//   const CapsuleHomeScreen({super.key});
//
//   @override
//   State<CapsuleHomeScreen> createState() => _CapsuleHomeScreenState();
// }
//
// class _CapsuleHomeScreenState extends State<CapsuleHomeScreen> {
//   String selectedTab = 'Active';
//
//   // FINAL DATA SOURCE: Includes 'unlocksIn' field for SnackBar logic
//   final List<Map<String, dynamic>> allCapsules = const [
//     {'title': 'Summer Trip Memories \'24', 'isLocked': true, 'creationDate': '10/15/2025', 'unlocksIn': '12 Days, 4 Hours'},
//     {'title': 'Graduation Day Archive', 'isLocked': false, 'creationDate': '05/20/2025', 'unlocksIn': 'Opened'},
//     {'title': 'Family Vacation 2023', 'isLocked': true, 'creationDate': '07/01/2025', 'unlocksIn': '90 Days, 1 Hour'},
//     {'title': 'Holiday Party Photos', 'isLocked': false, 'creationDate': '12/10/2024', 'unlocksIn': 'Opened'},
//     {'title': 'Work Project Launch', 'isLocked': true, 'creationDate': '09/05/2025', 'unlocksIn': '30 Days, 18 Hours'},
//   ];
//
//   // --- NEW: Click Logic Handler (SnackBar or Navigation) ---
//   void _handleCardTap(BuildContext context, Map<String, dynamic> capsule) {
//     if (capsule['isLocked'] == true) {
//       // --- LOCKED ACTION: Show SnackBar with time remaining ---
//       final snackBar = SnackBar(
//         content: Text('Unlocks in: ${capsule['unlocksIn']!}'),
//         duration: const Duration(seconds: 3),
//         backgroundColor: kPrimaryAccentColor,
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//     } else {
//       // --- UNLOCKED ACTION: Navigate to Capsule Details Screen (Screen 16) ---
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CapsuleDetailScreen(
//             capsuleTitle: capsule['title']!,
//             isLocked: false,
//             creationDate: capsule['creationDate']!,
//             unlocksIn: capsule['unlocksIn']!,
//             // Placeholders for content that would normally come from a database
//             mockMediaUrls: const ['url1', 'url2'],
//             mockNotes: 'A delightful note from collaborators.',
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kAppBackground,
//       appBar: AppBar(
//         backgroundColor: kAppBackground,
//         foregroundColor: kAppBarForeground,
//         elevation: 0,
//
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             const CircleAvatar(
//               radius: 18,
//               backgroundColor: kPrimaryAccentColor,
//               child: Text('U', style: TextStyle(color: Colors.black)),
//             ),
//             const SizedBox(width: 10),
//             Text('Capsules', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kAppBarForeground)),
//           ],
//         ),
//         actions: [
//           // Pending Invites/Friends Icon
//           IconButton(
//             icon: const Icon(Icons.person_add_alt_1_outlined, color: kAppBarForeground),
//             onPressed: () { /* TODO: Navigate to Friend Requests Screen */ },
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         children: [
//           _buildFilterTabs(),
//           const SizedBox(height: 20),
//           _buildFilteredList(selectedTab),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const CreateCapsuleScreen()),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//       bottomNavigationBar: _buildBottomNavBar(),
//     );
//   }
//
//   // --- Helper: Tab Styling and Logic ---
//   Widget _buildFilterTabs() {
//     return Row(
//       children: ['Active', 'Locked', 'Unlocked'].map((tab) {
//         bool isSelected = selectedTab == tab;
//         return Padding(
//           padding: const EdgeInsets.only(right: 12.0),
//           child: GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedTab = tab;
//               });
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//               decoration: BoxDecoration(
//                 color: isSelected ? kPrimaryAccentColor : const Color(0xFF303030),
//                 borderRadius: BorderRadius.circular(30), // CAPSULE SHAPE
//               ),
//               child: Text(
//                   tab,
//                   style: TextStyle(
//                     color: isSelected ? Colors.black : kAppBarForeground,
//                     fontWeight: FontWeight.w600,
//                   )
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   // --- Helper: Filtering and Card Generation ---
//   Widget _buildFilteredList(String tab) {
//     List filteredList;
//
//     // Filtering logic based on tab selection
//     if (tab == 'Locked') {
//       filteredList = allCapsules.where((c) => c['isLocked'] == true).toList();
//     } else if (tab == 'Unlocked') {
//       filteredList = allCapsules.where((c) => c['isLocked'] == false).toList();
//     } else {
//       filteredList = allCapsules; // 'Active' tab shows all
//     }
//
//     // Build the VisualCard for each item
//     return Column(
//       children: filteredList.map((capsule) {
//         bool isLocked = capsule['isLocked'] as bool;
//         String creationDate = capsule['creationDate'] as String;
//
//         // Correctly apply pastel tint against the dark background
//         Color color = isLocked ? kLockedCapsuleBase : kUnlockedCapsuleBase;
//
//         return VisualCapsuleCard(
//           title: capsule['title']!,
//           baseColor: color,
//           isLocked: isLocked,
//           creationDate: creationDate,
//           // --- PASS INTERACTIVITY HANDLER ---
//           onTap: () => _handleCardTap(context, capsule),
//         );
//       }).toList(),
//     );
//   }
//
//   // --- Helper: Bottom Navigation Bar ---
//   Widget _buildBottomNavBar() {
//     return BottomNavigationBar(
//       backgroundColor: const Color(0xFF1E1E1E),
//       selectedItemColor: kPrimaryAccentColor,
//       unselectedItemColor: kAppBarForeground.withOpacity(0.5),
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//       type: BottomNavigationBarType.fixed,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.forum), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.folder), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//       ],
//     );
//   }
// }

// lib/features/capsules/screens/capsule_home_screen.dart

import 'package:flutter/material.dart';
import 'package:lock_connect/core/constants/colors.dart';
import '../widgets/visual_capsule_card.dart';
import 'create_capsule_screen.dart';
import 'capsule_detail_screen.dart'; // Needed for navigation

// --- DARK MODE OVERRIDES ---
const Color kAppBackground = Color(0xFF121212); // Deep Black Background
const Color kAppBarForeground = Colors.white; // White icons/text on dark background

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

  // --- UPDATED: Click Logic Handler (Custom Dialog or Navigation) ---
  void _handleCardTap(BuildContext context, Map<String, dynamic> capsule) {
    if (capsule['isLocked'] == true) {
      // --- LOCKED ACTION: Show Custom Countdown Dialog (UX IMPROVEMENT) ---
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: kAppBackground, // Dark background for contrast
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Center(
                child: Text(
                    'Capsule Sealed',
                    style: TextStyle(color: kPrimaryAccentColor, fontWeight: FontWeight.w300)
                )
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_rounded, size: 52, color: Colors.white),
                const SizedBox(height: 20),
                // Display the time prominently
                Text(
                    'Unlocks in:',
                    style: TextStyle(color: Colors.white70, fontSize: 12)
                ),
                Text(
                    capsule['unlocksIn']!, // e.g., "12 Days, 4 Hours"
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400)
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('OK', style: TextStyle(color: kPrimaryAccentColor)),
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
    return Scaffold(
      backgroundColor: kAppBackground,
      appBar: AppBar(
        backgroundColor: kAppBackground,
        foregroundColor: kAppBarForeground,
        elevation: 0,

        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: kPrimaryAccentColor,
              child: Text('U', style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(width: 10),
            Text('Capsules', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kAppBarForeground)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1_outlined, color: kAppBarForeground),
            onPressed: () { /* TODO: Navigate to Friend Requests Screen */ },
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateCapsuleScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
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
                color: isSelected ? kPrimaryAccentColor : const Color(0xFF303030),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? Colors.black : kAppBarForeground,
                    fontWeight: FontWeight.w600,
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

  // --- Helper: Bottom Navigation Bar ---
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: kPrimaryAccentColor,
      unselectedItemColor: kAppBarForeground.withOpacity(0.5),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.forum), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.folder), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}