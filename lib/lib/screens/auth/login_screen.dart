import 'package:flutter/material.dart';
import '../../backend/services/auth_service.dart';
import '../../theme/app_colors.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Helper to show Styled SnackBars
  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold),
        ),
        // Using Purple for a professional look that fits your theme
        backgroundColor: isError ? AppColors.sunsetPurple : AppColors.sunsetOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // 1. Basic Validation
    if (email.isEmpty || password.isEmpty) {
      _showMessage('Please enter both email and password.', isError: true);
      return;
    }

    // 2. Simple Length Check for Login
    if (password.length < 7) {
      _showMessage('Password must be at least 7 characters.', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 3. Call Firebase Sign In
      await _authService.signIn(email, password);

      if (mounted) {
        _showMessage('Welcome back to Rekindl!');
      }
    } catch (e) {
      if (mounted) {
        _showMessage(
            e.toString().replaceFirst('Exception: ', 'Login Failed: '),
            isError: true
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Box
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(2, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                ),

                const SizedBox(height: 30),

                const Text(
                  'Welcome Back to Rekindl',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldText,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),

                const SizedBox(height: 30),

                // Email Field
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.white70),
                    // UPDATED HINT TEXT HERE
                    hintText: 'Email (e.g. name@rekindl.com)',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  ),
                ),

                const SizedBox(height: 15),

                // Password Field
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.6),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  ),
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.sunsetOrange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 8,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                        : const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'Don’t have an account? ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'PlayfairDisplay',
                      ),
                      children: [
                        TextSpan(
                          text: 'Get Started',
                          style: TextStyle(
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
}