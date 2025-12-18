import 'package:flutter/material.dart';
import '../../backend/services/auth_service.dart';
import '../../theme/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _isCodeSent = false;
  String? _verificationId;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold),
        ),
        backgroundColor: isError ? AppColors.sunsetPurple : AppColors.sunsetOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // STEP 1: Request OTP
  void _handleSendOTP() async {
    String phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      _showMessage('Please enter your phone number.', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.sendOTP(phone, (verId) {
        setState(() {
          _verificationId = verId;
          _isCodeSent = true;
          _isLoading = false;
        });
        _showMessage('Verification code sent!');
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showMessage(e.toString().replaceFirst('Exception: ', ''), isError: true);
    }
  }

  // STEP 2: Verify OTP and Reset using the original function
  void _handleVerifyAndReset() async {
    String otp = _otpController.text.trim();

    // We provide a temporary password since we removed the field from UI
    // You can change 'Reset12345' to whatever default you prefer
    String tempPassword = "Reset${otp}!";

    if (otp.isEmpty) {
      _showMessage('Please enter the verification code.', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Calling your original function exactly as it was before
      await _authService.verifyOtpAndReset(_verificationId!, otp, tempPassword);

      if (mounted) {
        _showMessage('Identity Verified! Welcome Back!.');
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) Navigator.pop(context);
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showMessage(e.toString().replaceFirst('Exception: ', ''), isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.sunsetBlue, AppColors.sunsetPurple, AppColors.sunsetPink, AppColors.sunsetOrange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Text(
                    _isCodeSent ? 'Verify Identity' : 'Account Recovery',
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.goldText, fontFamily: 'PlayfairDisplay'),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    _isCodeSent
                        ? 'Enter the 6-digit code sent to your phone.'
                        : 'Enter your details to receive a recovery code.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 25),

                  if (!_isCodeSent) ...[
                    _buildTextField(controller: _emailController, hint: 'Email Address', icon: Icons.email),
                    const SizedBox(height: 15),
                    _buildTextField(controller: _phoneController, hint: 'Phone Number', icon: Icons.phone),
                  ] else ...[
                    _buildTextField(controller: _otpController, hint: '6-Digit Code', icon: Icons.pin_outlined),
                  ],

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : (_isCodeSent ? _handleVerifyAndReset : _handleSendOTP),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.sunsetOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 8,
                      ),
                      child: _isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : Text(_isCodeSent ? 'Verify & Reset' : 'Send Code', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      if (_isCodeSent) {
                        setState(() => _isCodeSent = false);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(_isCodeSent ? 'Edit Details' : 'Back to Login', style: const TextStyle(color: Colors.white70, fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hint, required IconData icon}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black.withOpacity(0.6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }
}