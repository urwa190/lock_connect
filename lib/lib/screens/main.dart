import 'package:flutter/material.dart';

// Assuming your HomeScreen and SplashScreen are correctly located here:
import 'package:lock_connect/screens/home_screen.dart';

import '../../core/constants/app_colors.dart';
import 'auth/splash_screen.dart';
//import 'package:lock_connect/screens/auth/splash_screen.dart'; // Your imported Splash Screen
//import 'package:lock_connect/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rekindl MAD Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Set a default theme/color scheme here if needed, or use custom styling
        // You can set one of your custom fonts (PlayfairDisplay or RobotoFont) globally here:
        fontFamily: 'PlayfairDisplay', // Set Playfair Display as the app default
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColors.sunsetBlue,
          secondary: AppColors.sunsetPink,
          background: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),

      // Define named routes for navigation
      initialRoute: '/', // The default route is always the SplashScreen
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(), // Define the route to your main screen
      },

      // We no longer set 'home: const HomeScreen()' directly because the routes handle navigation
    );
  }
}
