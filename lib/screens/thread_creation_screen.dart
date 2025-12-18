import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Database
import 'package:firebase_auth/firebase_auth.dart';    // For User Info
import 'notifications_screen.dart';
import '../theme/AppColors.dart';

class ThreadCreationScreen extends StatefulWidget {
  const ThreadCreationScreen({super.key});

  @override
  State<ThreadCreationScreen> createState() => _ThreadCreationScreenState();
}

class _ThreadCreationScreenState extends State<ThreadCreationScreen> {
  final TextEditingController _threadController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPosting = false; // Prevents multiple clicks while uploading

  @override
  void dispose() {
    _threadController.dispose();
    super.dispose();
  }

  // 🚀 BACKEND LOGIC: Saving the Thread to Firestore
  void _submitThread() async {
    final threadText = _threadController.text.trim();

    if (threadText.isNotEmpty) {
      setState(() => _isPosting = true); // Show loading spinner

      try {
        // 1. Get the Current Logged-in User
        final user = _auth.currentUser;

        // 2. Identify Name (Uses Display Name, then Email prefix, then 'Explorer')
        String displayName = user?.displayName ?? user?.email?.split('@')[0] ?? 'Explorer';

        // 3. Identify Avatar (Uses User Photo, otherwise defaults to your Logo)
        String avatarUrl = user?.photoURL ?? 'assets/logo.png';

        // 4. Save to the shared 'posts' collection
        await FirebaseFirestore.instance.collection('posts').add({
          'authorName': displayName,
          'authorAvatarUrl': avatarUrl,
          'caption': threadText,
          'mediaUrl': '', // Threads have no images/videos
          'isThread': true,
          'isVideo': false,
          'timestamp': FieldValue.serverTimestamp(),
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Thread posted successfully!",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
              ),
              backgroundColor: AppColors.sunsetPurple,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context); // Return to Home Feed
        }
      } catch (e) {
        debugPrint("Error posting thread: $e");
        if (mounted) {
          setState(() => _isPosting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to post. Check connection.")),
          );
        }
      }
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
        backgroundColor: Colors.transparent, // Gradient shows through
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "Thread Creation",
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      color: AppColors.goldText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsScreen(userName: 'User'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "What's on your mind today?",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _threadController,
                          maxLines: 6,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Type your thread here...",
                            hintStyle: const TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.grey[900]?.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.pinkAccent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.pinkAccent),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 🌟 Show Spinner if posting, otherwise show Button
                        _isPosting
                            ? const CircularProgressIndicator(color: Colors.pinkAccent)
                            : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _submitThread,
                          child: const Text(
                            "Post Thread",
                            style: TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}