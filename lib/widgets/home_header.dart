import 'package:flutter/material.dart';
import '../theme/app_colors.dart';        // color definitions


class HomeHeader extends StatelessWidget {
  final String userName;
  final VoidCallback onNotificationTap;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // 🎨 Background color of the header
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            userName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.goldText, // Text color
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: onNotificationTap,
          ),
        ],
      ),
    );
  }
}
