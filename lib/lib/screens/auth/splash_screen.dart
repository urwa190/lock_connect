import 'package:flutter/material.dart';
import 'package:lock_connect/lib/screens/auth/welcome_screen.dart';

import '../../../core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Duration for splash screen
    Future.delayed(const Duration(seconds: 3, milliseconds: 1600), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF281637),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // GIF Animation
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/anima.gif',
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 25),

              // App Name
              const Text(
                'Rekindle',
                style: TextStyle(
                  color: AppColors.goldText,
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 10),

              // Tagline
              const Text(
                'Share Moments. Unlock Memories.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
