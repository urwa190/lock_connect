import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'friend_profile_screen.dart'; // Import FriendProfileScreen

class FriendsScreen extends StatelessWidget {
  final int friendsCount;

  const FriendsScreen({super.key, required this.friendsCount});

  @override
  Widget build(BuildContext context) {
    // Default list of friends
    final List<Map<String, dynamic>> friendsList = [
      {'name': 'Alice', 'bio': 'Loves photography', 'threads': 5, 'capsules': 10, 'friends': 12},
      {'name': 'Bob', 'bio': 'Coffee enthusiast', 'threads': 3, 'capsules': 8, 'friends': 9},
      {'name': 'Charlie', 'bio': 'Travel junkie', 'threads': 7, 'capsules': 5, 'friends': 15},
      {'name': 'Daisy', 'bio': 'Foodie and chef', 'threads': 2, 'capsules': 6, 'friends': 7},
      {'name': 'Ethan', 'bio': 'Tech geek', 'threads': 9, 'capsules': 12, 'friends': 20},
      {'name': 'Fiona', 'bio': 'Music lover', 'threads': 4, 'capsules': 7, 'friends': 8},
      {'name': 'George', 'bio': 'Sports fanatic', 'threads': 6, 'capsules': 9, 'friends': 14},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.sunsetBlue,
        iconTheme: const IconThemeData(color: AppColors.goldText),
        title: Text(
          'Friends ($friendsCount)',
          style: const TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
            color: AppColors.goldText,
          ),
        ),
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
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          itemCount: friendsList.length,
          itemBuilder: (context, index) {
            final friend = friendsList[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6), // Updated fill color
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  // Delete Icon
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Delete ${friend['name']} tapped')),
                      );
                    },
                    icon: const Icon(Icons.delete, color: AppColors.textHint),
                  ),

                  // Friend Profile Picture
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 12),

                  // Friend Name & Bio
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to FriendProfileScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FriendProfileScreen(
                              name: friend['name'],
                              bio: friend['bio'],
                              threads: friend['threads'],
                              capsules: friend['capsules'],
                              friendsCount: friend['friends'],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            friend['name'],
                            style: const TextStyle(
                              color: AppColors.goldText,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PlayfairDisplay',
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            friend['bio'],
                            style: const TextStyle(
                              color: AppColors.textHint,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // More options
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, color: AppColors.textHint),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
