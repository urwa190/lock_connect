import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'friends_screen.dart';

class FriendProfileScreen extends StatefulWidget {
  final String name;
  final String bio;
  final int threads;
  final int capsules;
  final int friendsCount;

  const FriendProfileScreen({
    super.key,
    required this.name,
    required this.bio,
    this.threads = 0,
    this.capsules = 0,
    this.friendsCount = 0,
  });

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.sunsetBlue,
        title: Text(
          widget.name,
          style: const TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
            color: AppColors.goldText,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                // 🔹 Centered DP
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white, size: 60),
                ),
                const SizedBox(height: 20),
                // 🔹 Name
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldText,
                  ),
                ),
                const SizedBox(height: 8),
                // 🔹 Bio
                Text(
                  widget.bio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 25),
                // 🔹 Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ProfileStat(label: 'Threads', value: widget.threads.toString()),
                    _ProfileStat(label: 'Capsules', value: widget.capsules.toString()),
                    _ProfileStat(label: 'Friends', value: widget.friendsCount.toString()),
                  ],
                ),
                const SizedBox(height: 25),
                // 🔹 Tabs Row (Collections / Capsules / Threads)
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
                      _buildTabItem(1, Icons.all_inclusive, 'Capsules'),
                      _buildTabItem(2, Icons.forum_outlined, 'Threads'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // 🔹 Tab Content
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _selectedTab == 0
                        ? _buildCollectionSection()
                        : _selectedTab == 1
                        ? _buildCapsulesSection()
                        : _buildThreadsSection(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Helper: Tabs with Icons
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

  // 🔹 Sections
  // This section keeps the GridView for Collections
  Widget _buildCollectionSection() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      // Title set to 'Shared Collection' for friend's view
      children: List.generate(4, (index) => const CollectionBox(title: 'Food')),
    );
  }

  // MODIFIED: Capsules section shows placeholder text
  Widget _buildCapsulesSection() {
    return const Center(
      child: Text(
        'Capsules are private or empty for this user.',
        key: ValueKey('friend-capsules-empty'),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textHint,
          fontSize: 18,
          fontFamily: 'PlayfairDisplay',
        ),
      ),
    );
  }

  // MODIFIED: Threads section shows placeholder text
  Widget _buildThreadsSection() {
    return const Center(
      child: Text(
        'No recent Threads to display.',
        key: ValueKey('friend-threads-empty'),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textHint,
          fontSize: 18,
          fontFamily: 'PlayfairDisplay',
        ),
      ),
    );
  }
}

// 🔸 Profile Stat Widget
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

// 🔸 Collection Box Widget
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