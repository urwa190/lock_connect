import 'package:flutter/material.dart';
import 'package:lock_connect/theme/app_colors.dart';
import '../widgets/home_header.dart';
import '../widgets/post_card.dart';
import '../models/post_model.dart';
import 'notifications_screen.dart';
import 'threads_screen.dart';
import 'thread_creation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<PostModel> posts = mockPosts;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      _showCreateMenu();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showCreateMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCreateOption("Post a Thread", Icons.forum, () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThreadCreationScreen(),
                  ),
                );
              }),
              _buildCreateOption("Post a Picture", Icons.image, () {
                Navigator.pop(context);
                _showCollectionPicker("Picture");
              }),
              _buildCreateOption("Post a Video", Icons.videocam, () {
                Navigator.pop(context);
                _showCollectionPicker("Video");
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCreateOption(String label, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  void _showCollectionPicker(String type) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final collections = ["Travel", "Food", "School", "Personal"];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose a collection for your $type",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 12),
              ...collections.map((collection) {
                return ListTile(
                  title: Text(collection, style: const TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Posted to $collection")),
                    );
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(
            userName: "Rekindle",
            onNotificationTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationsScreen(userName: 'Sarah'),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Home Feed",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: posts[index]);
              },
            ),
          ),
        ],
      );
    } else {
      return const ThreadsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.transparent,
        body: SafeArea(child: _buildBody()),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black.withOpacity(0.6),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum),
              label: 'Threads',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create),
              label: 'Create',
            ),
          ],
        ),
      ),
    );
  }
}
