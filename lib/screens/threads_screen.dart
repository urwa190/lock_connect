import 'package:flutter/material.dart';
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
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title:const Text( "Threads",
                  style: TextStyle(fontFamily:'PlayfairDisplay', color:AppColors.goldText,fontSize: 24, fontWeight: FontWeight.bold ),
                ), actions: [
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsScreen(userName: 'Sarah'),
                      ),
                    );
                  },
                ),
              ],
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
