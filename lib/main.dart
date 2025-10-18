// lib/main.dart

import 'package:flutter/material.dart';
import 'core/constants/colors.dart';
// Import your start screen
import 'features/capsules/screens/capsule_home_screen.dart';

void main() {
  runApp(const LockConnectApp());
}

class LockConnectApp extends StatelessWidget {
  const LockConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lock Connect',
      debugShowCheckedModeBanner: false,

      // --- THEME FIX: Switching to Light Mode and Soft Colors ---
      theme: ThemeData(
        brightness: Brightness.light, // Set primary brightness to light
        scaffoldBackgroundColor: kLightBackgroundColor, // Use the new light background
        cardColor: kCardColor, // Cards are white/light

        // Set the gold accent color (for FAB, selected tabs, etc.)
        primaryColor: kPrimaryAccentColor,
        colorScheme: ColorScheme.light( // Use Light ColorScheme
          primary: kPrimaryAccentColor,
          background: kLightBackgroundColor,
          surface: kCardColor,
        ),

        // Define text styles for dark text on light backgrounds
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: kDarkTextColor),
          bodyMedium: TextStyle(color: kDarkTextColor),
          titleLarge: TextStyle(color: kDarkTextColor, fontWeight: FontWeight.bold),
        ),

        // Style the Floating Action Button (FAB)
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kPrimaryAccentColor,
          foregroundColor: Colors.black, // Black text/icon on gold button
          shape: CircleBorder(),
        ),

        // Style the App Bar to blend with the background
        appBarTheme: const AppBarTheme(
          backgroundColor: kLightBackgroundColor,
          foregroundColor: kDarkTextColor,
          elevation: 0, // Remove shadow for a clean look
        ),

        useMaterial3: true,
      ),

      // Starts the app on the Capsule Home Screen
      home: CapsuleHomeScreen(),
    );
  }
}