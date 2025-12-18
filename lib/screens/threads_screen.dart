import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/post_card.dart';
import '../models/post_model.dart';
import '../theme/AppColors.dart';

class ThreadsScreen extends StatelessWidget {
  const ThreadsScreen({Key? key}) : super(key: key);

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Community Threads",
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              color: AppColors.goldText,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          // Filters the database to show only text threads
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('isThread', isEqualTo: true)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppColors.goldText));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No threads yet.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            final threadDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: threadDocs.length,
              itemBuilder: (context, index) {
                final doc = threadDocs[index];
                final data = doc.data() as Map<String, dynamic>;

                final threadPost = PostModel(
                  id: doc.id,
                  authorName: data['authorName'] ?? 'Member',
                  authorAvatarUrl: data['authorAvatarUrl'] ?? 'assets/logo.png',
                  caption: data['caption'] ?? '',
                  mediaUrl: '',
                  timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
                  isThread: true,
                  isVideo: false,
                  // Fixed: Added required videoPath parameter
                  videoPath: '',
                );

                return PostCard(post: threadPost);
              },
            );
          },
        ),
      ),
    );
  }
}