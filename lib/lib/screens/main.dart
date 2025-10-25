import 'package:flutter/material.dart';
// 1. IMPORT YOUR SPLASH SCREEN
import 'package:lock_connect/lib/screens/auth/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capsule Connect',
      debugShowCheckedModeBanner: false,
      // 2. SET SPLASH SCREEN AS THE HOME WIDGET
      home: const SplashScreen(),
    );
  }
}