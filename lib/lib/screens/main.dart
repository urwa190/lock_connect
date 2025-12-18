import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth/home_screen.dart';
import 'auth/login_screen.dart';
import 'auth/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase core
  runApp(const MyApp());
}
// ----------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capsule Connect',
      debugShowCheckedModeBanner: false,
      // Change the home widget to the AuthGate
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), // Listen for login/logout events
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show splash screen or loading spinner while checking auth status
            return const SplashScreen(); // Your splash screen
          }

          if (snapshot.hasData) {
            // User is logged in, show the main content
            return const HomeScreen();
          }

          // User is NOT logged in, show the login/signup screens
          return const LoginScreen();
        },
      ),
    );
  }
}