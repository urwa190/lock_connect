import 'package:flutter/material.dart';
import '../theme/AppColors.dart'; // color definitions

class NotificationsScreen extends StatefulWidget {
  final String userName; //  receives username from HomeScreen
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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title:const Text( "Notifications",
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
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    SwitchListTile(
                      title: const Text(
                        'Do Not Disturb',
                        style: TextStyle(color: Colors.white),
                      ),
                      value: isDoNotSleepEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          isDoNotSleepEnabled = value;
                        });

                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Do Not Disturb Enabled',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                              backgroundColor: AppColors.sunsetPurple,
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.notifications, color: Colors.white),
                      title: const Text(
                        'New message from Sarah',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        '2min ago',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.notifications, color: Colors.white),
                      title: const Text(
                        'Nancy liked your post',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        '7min ago',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.notifications, color: Colors.white),
                      title: const Text(
                        'New message from Ali',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        '2h ago',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.notifications,color: Colors.white),
                      title: const Text(
                        'Sarah commented on your post',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        '5d ago',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.notifications,color: Colors.white),
            title: const Text(
              'New message from Leo',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              '20min ago',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.notifications,color: Colors.white),
            title: const Text(
              'New message from Sam',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              '60min ago',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
