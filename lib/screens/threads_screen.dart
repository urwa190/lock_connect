import 'package:flutter/material.dart';
import '../widgets/home_header.dart';     // top row with username and bell icon
import '../widgets/post_card.dart';      // reusable post layout
import '../models/post_model.dart';      // mockPosts and PostModel
import '../theme/app_colors.dart';       // color definitions
import 'notifications_screen.dart';      // navigation target

class ThreadsScreen extends StatelessWidget {
  const ThreadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PostModel> threadPosts = mockPosts.where((post) => post.isThread).toList();

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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                userName: "Rekindle", // ✅ Gold-styled in HomeHeader widget
                onNotificationTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsScreen(userName: 'Sarah'),
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Your Threads",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: threadPosts.length,
                  itemBuilder: (context, index) {
                    return PostCard(post: threadPosts[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
