import 'package:flutter/material.dart';
import 'package:lock_connect/screens/threads_screen.dart';

// Assuming these imports point to the correct files in your project structure:
import '../../../features/capsules/screens/capsule_home_screen.dart'; // CapsuleHomeScreen
import 'profile_screen.dart'; // ProfileScreen

// Custom files (assuming these are in the same directory or imported elsewhere)
import '../../theme/app_colors.dart';
// *** NEW: Import the post menu utility file from utilities/post_menu.dart ***
// You may need to adjust the relative path based on your exact structure
import '../../../utils/post_menu.dart';

// Create placeholder classes for the missing screens so the code compiles.
// Replace these with your actual imported screen widgets.
class threads_screen extends StatelessWidget { const threads_screen({super.key}); @override Widget build(BuildContext context) { return const Center(child: Text('Threads Content', style: TextStyle(color: AppColors.goldText))); } }
class notifications_screen extends StatelessWidget { const notifications_screen({super.key}); @override Widget build(BuildContext context) { return const Center(child: Text('Notifications Content', style: TextStyle(color: AppColors.goldText))); } }

// Define a placeholder screen for the 'Create' tab, which is actually the menu trigger.
class CreateMenuPlaceholder extends StatelessWidget {
  const CreateMenuPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    // This screen is displayed only if the index happens to land on '2',
    // but the onTap handler will prevent the index from staying on 2.
    return const Center(child: Text('Tap the + to Create', style: TextStyle(color: AppColors.goldText, fontSize: 18)));
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // We initialize the selected index to 0 (Home).
  int _selectedIndex = 0;

  // Screens for each tab: MUST match the 5 BottomNavigationBarItems exactly.
  // [0] Home -> [1] Capsules -> [2] Create -> [3] Threads -> [4] Profile
  final List<Widget> _screens = [
    // [0] HOME TAB (Assuming this is the notifications screen based on your list order)
    const HomeScreen(),

    // [1] CAPSULES TAB
    const CapsuleHomeScreen(),

    // [2] CREATE TAB (Placeholder widget for the index that triggers the menu)
    const CreateMenuPlaceholder(),

    // [3] THREADS TAB
    const ThreadsScreen(),

    // [4] PROFILE TAB
    const ProfileScreen(),
  ];

  // *** MODIFIED FUNCTION ***
  void _onItemTapped(int index) {
    // Index 2 corresponds to the 'Create' button
    if (index == 2) {
      // 1. Call the function from your utility file
      showCreatePostMenu(context);

      // 2. IMPORTANT: Return here. This prevents setState, meaning
      // the tab bar stays visually on the previously selected tab (e.g., Home or Capsules).
      return;
    }

    // For all other indices (0, 1, 3, 4), update the state and switch the screen.
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
        // Renders the screen corresponding to the selected index
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
            icon: Icon(Icons.healing),
            label: 'Capsules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded), // Index 2: Create Button
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum), // Index 3: Threads
            label: 'Threads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile', // Index 4: Profile
          ),
        ],
      ),
    );
  }
}
