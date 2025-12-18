import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../backend/services/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true; // State for password eye toggle

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Improved Empty Field Check & Validation
  void _handleSignUp() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPass = _confirmPasswordController.text.trim();

    // 1. Check for empty fields (Mandatory check)
    if (username.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirmPass.isEmpty) {
      _showMessage('All fields marked with * are mandatory.', isError: true);
      return;
    }

    // 2. Password Match Check
    if (password != confirmPass) {
      _showMessage('Passwords do not match.', isError: true);
      return;
    }

    // 3. Password Length Check
    if (password.length < 7) {
      _showMessage('Password must be at least 7 characters.', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signUp(username, email, password, phone);
      if (mounted) {
        _showMessage('Account created successfully!');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (
              route) => false,
        );
      }
    } catch (e) {
      if (mounted) _showMessage(e.toString().replaceFirst('Exception: ', ''), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: 'PlayfairDisplay')),
        backgroundColor: isError ? AppColors.sunsetPurple : AppColors.sunsetOrange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Text('Join Rekindl', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: AppColors.goldText)),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.white30)),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Using "*" in hints to show they are mandatory
                      _buildTextField(Icons.person, 'Username *', _usernameController),
                      const SizedBox(height: 16),
                      _buildTextField(Icons.email, 'Email * (e.g. name@rekindl.com)', _emailController),
                      const SizedBox(height: 16),
                      _buildTextField(Icons.phone, 'Phone Number *', _phoneController),
                      const SizedBox(height: 16),
                      // Password with Eye Toggle
                      _buildTextField(Icons.lock, 'Password *', _passwordController, isPassword: true),
                      const SizedBox(height: 16),
                      _buildTextField(Icons.lock_outline, 'Confirm Password *', _confirmPasswordController, isPassword: true),
                      const SizedBox(height: 28),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignUp,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: AppColors.sunsetOrange,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Get Started', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text.rich(TextSpan(text: 'Already have an account? ', style: TextStyle(color: Colors.white), children: [TextSpan(text: 'Log in', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.goldText))])),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Updated buildTextField with Eye Icon logic
  Widget _buildTextField(IconData icon, String hintText, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white, size: 24),
        // Adding the Eye Icon only for password fields
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.white70),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        )
            : null,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black.withOpacity(0.6),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.white30)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: AppColors.goldText)),
      ),
    );
  }
}