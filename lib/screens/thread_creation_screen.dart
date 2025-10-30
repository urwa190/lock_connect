import 'package:flutter/material.dart';
import '../theme/app_colors.dart'; // Gradient colors
import 'threads_screen.dart';     // Navigation target
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
        const SnackBar(content: Text("New thread posted",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
          backgroundColor: AppColors.sunsetPurple,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating),
      );
      _threadController.clear();
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
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title:const Text( "Thread Creation",
                  style: TextStyle(fontFamily: 'PlayfairDisplay',color:AppColors.goldText,fontSize: 24, fontWeight: FontWeight.bold ),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "What's on your mind today?",
                  style: TextStyle(fontFamily: 'Roboto',
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
                          child: const Text("Post Thread",
                          style: TextStyle(fontFamily: 'PlayfairDisplay'),
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
