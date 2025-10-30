import 'package:flutter/material.dart';
import 'package:lock_connect/screens/home_screen.dart';
import 'package:lock_connect/theme/app_colors.dart'; // Make sure this path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rekindl',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background, // ✅ Your custom background
        useMaterial3: true, // Optional: enables Material 3 widgets
      ),
      home: const HomeScreen(),
    );
  }
}
