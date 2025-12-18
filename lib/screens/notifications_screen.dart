import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/AppColors.dart';

class NotificationsScreen extends StatefulWidget {
  final String userName;
  const NotificationsScreen({super.key, required this.userName});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool isDoNotDisturb = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to format the Firestore timestamp into a readable string
  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "Just now";
    DateTime date = timestamp.toDate();
    Duration diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    return "${diff.inDays}d ago";
  }

  @override
  Widget build(BuildContext context) {
    // We identify the current user to only show notifications meant for them
    final String currentUserName = _auth.currentUser?.displayName ??
        _auth.currentUser?.email?.split('@')[0] ??
        widget.userName;

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
            "Notifications",
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              color: AppColors.goldText,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            // 🔇 DO NOT DISTURB SECTION (Kept your original UI)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Do Not Disturb",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Switch(
                      value: isDoNotDisturb,
                      activeColor: AppColors.goldText,
                      onChanged: (value) {
                        setState(() {
                          isDoNotDisturb = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // 🌟 LIVE NOTIFICATIONS LIST
            Expanded(
              child: isDoNotDisturb
                  ? const Center(
                child: Text(
                  "Notifications are paused",
                  style: TextStyle(color: Colors.white70),
                ),
              )
                  : StreamBuilder<QuerySnapshot>(
                // We filter notifications where recipientId matches the logged-in user
                stream: FirebaseFirestore.instance
                    .collection('notifications')
                    .where('recipientId', isEqualTo: currentUserName)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.goldText));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No new notifications",
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  final notifications = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      var data = notifications[index].data() as Map<String, dynamic>;
                      String type = data['type'] ?? 'like';
                      String sender = data['senderName'] ?? 'Someone';
                      String time = _formatTimestamp(data['timestamp'] as Timestamp?);

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: type == 'like' ? Colors.redAccent : Colors.blueAccent,
                            child: Icon(
                              type == 'like' ? Icons.favorite : Icons.comment,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          title: RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              children: [
                                TextSpan(text: sender, style: const TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: type == 'like' ? " liked your post" : " commented: '${data['content']}'"),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            time,
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}