import 'package:flutter/material.dart';
import 'package:lock_connect/screens/threads_screen.dart';
import '../../../features/capsules/screens/capsule_home_screen.dart';
import '../../theme/app_colors.dart';
import 'profile_screen.dart';
import 'package:lock_connect/utils/post_menu.dart';
import  'package:lock_connect/screens/home_screens.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreens(),         // 0
    CapsuleHomeScreen(),   // 1
    const ThreadsScreen(),       // 2 (will map from index 3)
    const ProfileScreen(),       // 3 (will map from index 4)
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      //Upload button tapped → call upload function/modal
      showCreatePostMenu(context);
    } else {
      setState(() {
        //Adjust index mapping because Upload isn't in _screens
        if (index > 2) {
          _selectedIndex = index - 1; // Shift after upload
        } else {
          _selectedIndex = index;
        }
      });
    }
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
        currentIndex: _selectedIndex < 2 ? _selectedIndex : _selectedIndex + 1, // fix highlighting
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