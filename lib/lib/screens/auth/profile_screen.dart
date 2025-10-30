import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'edit_profile.dart';
import 'explore_friends.dart';
import 'friends_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTab = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      endDrawer: _buildAppDrawer(context), // Updated Drawer
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.sunsetBlue,
        centerTitle: false,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
            color: AppColors.goldText,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            icon: const Icon(
              Icons.menu_rounded,
              color: AppColors.goldText,
              size: 30,
            ),
          ),
        ],
      ),
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Profile Picture + Stats
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blueAccent,
                          child: const Text(
                            'J',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PlayfairDisplay',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.sunsetOrange,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, size: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          _ProfileStat(label: 'Threads', value: '12'),
                          _ProfileStat(label: 'Capsules', value: '34'),
                          _ProfileStat(label: 'Friends', value: '7'),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 20),

                // Name & Bio
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldText,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Lover of memories and moments',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),

                // Edit Profile Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black26,
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Edit profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Tabs Row
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white24, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTabItem(0, Icons.collections, 'Collections'),
                      _buildTabItem(1, Icons.explore_outlined, 'Explore'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Tab Content
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _selectedTab == 0
                        ? _buildCollectionSection()
                        : _buildExploreSection(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Drawer _buildAppDrawer(BuildContext context) {
    const Color drawerBackgroundColor = AppColors.sunsetPurple;
    const Color headerBackgroundColor = Colors.white24;
    const Color textIconColor = Colors.white;

    return Drawer(
      backgroundColor: drawerBackgroundColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: headerBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey[400],
                    child: const Icon(Icons.person, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "John Doe",
                    style: TextStyle(
                      color: textIconColor,
                      fontSize: 20,
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // My Profile
          _drawerItem(Icons.person, "My Profile", () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }, textIconColor),

          // Settings
          _drawerItem(Icons.settings, "Settings", () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Settings will open the settings screen.",
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(seconds: 2),
                backgroundColor: AppColors.sunsetPurple
              ),
            );
          }, textIconColor),

          // Feedback
          _drawerItem(Icons.feedback_outlined, "Feedback", () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Feedback section coming soon.",
                style: TextStyle(color: Colors.white),),
                duration: Duration(seconds: 2),
                backgroundColor: AppColors.sunsetPurple,
              ),
            );
          }, textIconColor),

          // Help
          _drawerItem(Icons.help_outline, "Help", () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Help desk will open soon.",
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(seconds: 2),
                backgroundColor: AppColors.sunsetPurple,
              ),
            );
          }, textIconColor),

          const Spacer(),

          // Logout
          _drawerItem(Icons.logout, "Logout", () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: AppColors.sunsetPurple,
                title: const Text(
                  "Logout Confirmation",
                  style: TextStyle(
                    color: AppColors.goldText,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                content: const Text(
                  "Are you sure you want to logout?",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: AppColors.sunsetOrange),
                    ),
                  ),
                ],
              ),
            );
          }, textIconColor),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  ListTile _drawerItem(IconData icon, String title, VoidCallback onTap, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontFamily: 'PlayfairDisplay',
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios, color: color.withOpacity(0.5), size: 14),
    );
  }

  // Helper: Tabs with Icons
  Widget _buildTabItem(int index, IconData icon, String label) {
    final bool isSelected = _selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedTab = index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: isSelected
            ? const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.sunsetOrange, width: 3),
          ),
        )
            : null,
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.goldText : Colors.white70, size: 18),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.goldText : AppColors.textHint,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'PlayfairDisplay',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sections
  Widget _buildCollectionSection() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: List.generate(4, (index) => const CollectionBox(title: 'Travel')),
    );
  }

  // Explore Section
  Widget _buildExploreSection() {
    return Center(
      key: const ValueKey('explore'),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.sunsetOrange,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExploreFriendsScreen()),
          );
        },
        child: const Text(
          'Explore Friends',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Profile Stat Widget
class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (label == 'Friends') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendsScreen(friendsCount: int.parse(value)),
            ),
          );
        }
      },
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.goldText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'PlayfairDisplay',
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textHint,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// Collection Box Widget
class CollectionBox extends StatelessWidget {
  final String title;

  const CollectionBox({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.black.withOpacity(0.5),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(color: Colors.white24),
                Container(color: Colors.white30),
                Container(color: Colors.white24),
                Container(
                  color: Colors.black38,
                  child: const Center(
                    child: Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.sunsetOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.collections, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
