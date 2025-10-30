import 'package:flutter/material.dart';
import '../theme/app_colors.dart'; // color definitions

class NotificationsScreen extends StatefulWidget {
  final String userName; // 👤 receives username from HomeScreen
  const NotificationsScreen({super.key, required this.userName});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool isDoNotSleepEnabled = false;

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
        backgroundColor: Colors.transparent, // 👈 Let gradient show through
        appBar: AppBar(
          title: const Text('Notifications'),
          backgroundColor: Colors.purple,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Welcome, ${widget.userName}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text(
                'Do Not Sleep',
                style: TextStyle(color: Colors.white),
              ),
              value: isDoNotSleepEnabled,
              onChanged: (bool value) {
                setState(() {
                  isDoNotSleepEnabled = value;
                });

                if (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Do Not Sleep enabled')),
                  );
                }
              },
              activeColor: Colors.pinkAccent,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.white),
              title: const Text(
                'New message from Sarah',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                '2 min ago',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
