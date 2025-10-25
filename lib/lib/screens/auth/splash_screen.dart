import 'package:flutter/material.dart';
// 1. IMPORT YOUR COLOR/THEME FILE
import 'package:lock_connect/lib/theme/app_colors.dart';
// 2. IMPORT THE CORRECT NEXT SCREEN (WelcomeScreen)
import 'package:lock_connect/lib/screens/auth/welcome_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // This function handles the delay before navigating
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to the Welcome Screen (the sign-up/login choice page)
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()), // <- Navigates to WelcomeScreen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.primaryDarkBackground, // Deep Charcoal
      body: Center(
        // Added 'const' for performance
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 💡 Custom Splash Logo: Retro Camera in a Lock (Animated Placeholder)

            // Using const Icon and Text for better performance
            const Icon(
              Icons.lock_clock,
              size: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'CAPSULE CONNECT',
              style: TextStyle(
                //color: AppColors.lightTextColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Added the tagline to match the final design concept
            const SizedBox(height: 8),
            const Text(
              'Share Moments. Unlock Memories',
              style: TextStyle(
                //color: AppColors.lightTextColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}