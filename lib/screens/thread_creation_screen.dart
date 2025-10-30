import 'package:flutter/material.dart';
import '../theme/app_colors.dart'; // Gradient colors
import 'threads_screen.dart';     // Navigation target
import '../widgets/home_header.dart'; // Header with Rekindle and bell icon
import 'notifications_screen.dart';   // For notification navigation

class ThreadCreationScreen extends StatefulWidget {
  const ThreadCreationScreen({super.key});

  @override
  State<ThreadCreationScreen> createState() => _ThreadCreationScreenState();
}

class _ThreadCreationScreenState extends State<ThreadCreationScreen> {
  final TextEditingController _threadController = TextEditingController();

  @override
  void dispose() {
    _threadController.dispose();
    super.dispose();
  }

  void _submitThread() {
    final threadText = _threadController.text.trim();
    if (threadText.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New thread posted")), // ✅ Updated message
      );
      _threadController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ThreadsScreen()),
      );
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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                userName: "Rekindle",
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
                  "Create a Thread",
                  style: TextStyle(
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
                            fillColor: Colors.grey[900],
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          ),
                          onPressed: _submitThread,
                          child: const Text("Post Thread"),
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
