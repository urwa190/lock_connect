import 'package:flutter/material.dart';
import '../../../features/capsules/screens/capsule_home_screen.dart';
import '../../theme/app_colors.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Screens for each tab
  final List<Widget> _screens = [
    const Center(
      child: Text(
        'Welcome to Rekindl Home!',
        style: TextStyle(
          color: AppColors.goldText,
          fontSize: 24,
          fontFamily: 'PlayfairDisplay',
        ),
      ),
    ),
    const CapsuleHomeScreen(),

    const Center(
      child: Text(
        'Create Something New!',
        style: TextStyle(
          color: AppColors.goldText,
          fontSize: 24,
          fontFamily: 'PlayfairDisplay',
        ),
      ),
    ),
    const Center(
      child: Text(
        'Threads Screen',
        style: TextStyle(
          color: AppColors.goldText,
          fontSize: 24,
          fontFamily: 'PlayfairDisplay',
        ),
      ),
    ),
    const ProfileScreen(), //last one for Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.sunsetBlue,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),// Capsules buttone
            label: 'Capsules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded), //Create Button
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum), // Threads
            label: 'Threads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile', //for profile
          ),
        ],
      ),
    );
  }
}
