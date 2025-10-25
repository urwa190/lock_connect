import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ✨ Title
                const Text(
                  'Join Rekindl',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                    color: AppColors.goldText,
                  ),
                ),
                const SizedBox(height: 10),

                const Text(
                  'Create your account and start your journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'PlayfairDisplay',
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),

                // 📋 Form Container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white30, width: 1),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildTextField(Icons.person, 'Username'),
                      const SizedBox(height: 16),
                      _buildTextField(Icons.email, 'Email'),
                      const SizedBox(height: 16),
                      _buildTextField(Icons.lock, 'Password', obscureText: true),
                      const SizedBox(height: 16),
                      _buildTextField(Icons.lock_outline, 'Confirm Password', obscureText: true),
                      const SizedBox(height: 28),

                      // 🌟 Signup Button (original color, but new font)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: AppColors.sunsetOrange,
                            elevation: 8,
                            shadowColor: AppColors.sunsetOrange.withOpacity(0.6),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PlayfairDisplay', // 🎨 changed font here
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // 🔁 Login Link
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'PlayfairDisplay',
                      ),
                      children: [
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldText,
                            fontFamily: 'PlayfairDisplay',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🟣 TextField with white icons & simple style
  Widget _buildTextField(IconData icon, String hintText, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white, size: 28),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70, fontSize: 16),
        filled: true,
        fillColor: Colors.black.withOpacity(0.6),
        //fillColor: AppColors.sunsetPurple, // 💜 field color same
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.goldText),
        ),
      ),
    );
  }
}
