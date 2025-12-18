// lib/data/services/auth_service.dart (Create this file)
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ----------------------------------------------------
  // 1. SIGN UP (Auth Creation + Profile Document Creation)
  // ----------------------------------------------------
  Future<void> signUp(String username, String email, String password, String phoneNumber) async {
    try {
      // 1. Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // 2. Create corresponding Firestore profile document
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'username': username,
        'email': email,
        'createdAt': Timestamp.now(),
        'profileImageUrl': '', // Placeholder for now
      });

    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors (e.g., email-already-in-use)
      throw Exception(e.message);
    } catch (e) {
      // Handle generic errors
      throw Exception('An unexpected error occurred during sign up.');
    }
  }

  // ----------------------------------------------------
  // 2. SIGN IN (Login)
  // ----------------------------------------------------
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Handle errors like wrong password or user not found
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw Exception('Invalid email or password.');
      }
      throw Exception(e.message);
    }
  }

  // ----------------------------------------------------
  // 3. SIGN OUT
  // ----------------------------------------------------
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      // This sends a localized reset link to the user's email
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      // Pass the specific Firebase error back to the UI
      throw Exception(e.message ?? "An error occurred.");
    }
  }

  //// Sends a 6-digit OTP to the user's phone
  Future<void> sendOTP(String phoneNumber, Function(String) onCodeSent) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This can happen on some Android devices for auto-verification
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception(e.message ?? "Phone verification failed.");
        },
        codeSent: (String verificationId, int? resendToken) {
          // Pass the verificationId back to the UI to store it
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      throw Exception("Error sending OTP: $e");
    }
  }

  /// Verifies the OTP and updates the user's password
  Future<void> verifyOtpAndReset(String verificationId, String smsCode, String newPassword) async {
    try {
      // 1. Create a credential from the OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // 2. Sign in with that credential to prove identity
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // 3. Once signed in, update the password
      if (userCredential.user != null) {
        await userCredential.user!.updatePassword(newPassword);
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Failed to verify OTP or update password.");
    }
    Future<void> loginWithPhone(String verificationId, String smsCode) async {
      try {
        // 1. Create the credential from the OTP
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );

        // 2. Sign in with the credential
        // If the user doesn't exist, Firebase creates them automatically.
        UserCredential userCredential = await _auth.signInWithCredential(credential);

        // 3. (Optional) Check if they are new to add them to Firestore
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          await _firestore.collection('users').doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,
            'phoneNumber': userCredential.user!.phoneNumber,
            'createdAt': Timestamp.now(),
            'method': 'phone',
          });
        }
      } catch (e) {
        throw Exception("Phone Login Failed: $e");
      }
    }
  }
}