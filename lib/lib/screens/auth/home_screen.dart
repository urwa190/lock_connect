// import 'package:flutter/material.dart';
// import 'package:lock_connect/screens/threads_screen.dart';
// import '../../../features/capsules/screens/capsule_home_screen.dart';
// import '../../theme/app_colors.dart';
// import 'profile_screen.dart';
// import 'package:lock_connect/utils/post_menu.dart';
// import  'package:lock_connect/screens/home_screens.dart';
// import 'package:lock_connect/features/capsules/screens/capsule_home_screen.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//
// // ✅ Only include real screens — exclude Upload
//   final List<Widget> _screens = [
//     const HomeScreens(),         // 0
//     const CapsuleHomeScreen(),   // 1
//     const ThreadsScreen(),       // 2 (will map from index 3)
//     const ProfileScreen(),       // 3 (will map from index 4)
//   ];
//
//   void _onItemTapped(int index) {
//     if (index == 2) {
//       // 🔹 Upload button tapped → call upload function/modal
//       showCreatePostMenu(context);
//     } else {
//       setState(() {
//         // 🔹 Adjust index mapping because Upload isn't in _screens
//         if (index > 2) {
//           _selectedIndex = index - 1; // Shift after upload
//         } else {
//           _selectedIndex = index;
//         }
//       });
//     }
//   }
//
//
//   // // Screens for each tab (excluding Create because it shows modal)
//   // final List<Widget> _screens = [
//   //   const Center(child: Text('Home Content', style: TextStyle(color: Colors.white))),
//   //   const HomeScreens(),
//   //   const CapsuleHomeScreen(),
//   //   const ThreadsScreen(),
//   //   const ProfileScreen(),
//   // ];
//   //
//   // void _onItemTapped(int index) {
//   //   if (index == 3) {
//   //     // 👇 when Create button tapped, open Post Menu instead of switching screen
//   //     showCreatePostMenu(context);
//   //   } else {
//   //     setState(() {
//   //       // Adjusted index mapping (because Create is skipped)
//   //       _selectedIndex = index < 2 ? index : index - 1;
//   //     });
//   //   }
//   // }
//
//   // Screens for each tab (excluding Create because it shows modal)
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppColors.sunsetBlue,
//               AppColors.sunsetPurple,
//               AppColors.sunsetPink,
//               AppColors.sunsetOrange,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: _screens[_selectedIndex],
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   currentIndex: _selectedIndex,
//       //   onTap: _onItemTapped,
//       //   backgroundColor: Colors.black.withOpacity(0.5),
//       //   type: BottomNavigationBarType.fixed,
//       //   selectedItemColor: AppColors.sunsetBlue,
//       //   unselectedItemColor: Colors.white70,
//       //   selectedFontSize: 13,
//       //   unselectedFontSize: 12,
//       //   showUnselectedLabels: true,
//       //   items: const [
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.home_filled),
//       //       label: 'Home',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.healing),
//       //       label: 'Capsules',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.add_box_rounded),
//       //       label: 'Create',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.forum),
//       //       label: 'Threads',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.person),
//       //       label: 'Profile',
//       //     ),
//       //   ],
//       // ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.black,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _selectedIndex < 2 ? _selectedIndex : _selectedIndex + 1, // fix highlighting
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Capsule'),
//           BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Upload'),
//           BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Threads'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:lock_connect/screens/threads_screen.dart';
import 'package:lock_connect/features/capsules/screens/capsule_home_screen.dart';
import 'package:lock_connect/features/capsules/services/capsule_service.dart';
import 'package:lock_connect/features/capsules/services/cloudinary_upload.dart';
import 'package:lock_connect/utils/post_menu.dart';
import 'package:lock_connect/screens/home_screens.dart';
import '../../theme/app_colors.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Initialize CapsuleService with Cloudinary config
  final _capsuleService = CapsuleService(
    uploader: CloudinaryUploader(
      cloudName: 'YOUR_CLOUD_NAME',
      uploadPreset: 'YOUR_UNSIGNED_PRESET',
    ),
  );

  // Screens for tabs (Upload is not a screen; it opens the modal)
  late final List<Widget> _screens = [
    const HomeScreens(),       // index 0
    CapsuleHomeScreen(capsuleService: _capsuleService),       // index 1
    const ThreadsScreen(),     // index 2 (mapped from nav index 3)
    const ProfileScreen(),     // index 3 (mapped from nav index 4)
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Upload button tapped → show post menu
      showCreatePostMenu(context);
      return;
    }
    setState(() {
      _selectedIndex = index > 2 ? index - 1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        // Highlight the correct item (Upload is a non-screen in the middle)
        currentIndex: _selectedIndex < 2 ? _selectedIndex : _selectedIndex + 1,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Capsule'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Upload'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Threads'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
