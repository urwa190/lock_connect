import 'package:firebase_auth/firebase_auth.dart';

/// Temporary fallback while auth is not ready.
/// Replace the const below when real sign-in is active.
const String kFallbackUserId = 'q9mdwjnKxwdE59tIAOnydkcLMM32';

String currentUserIdOrFallback() {
  final user = FirebaseAuth.instance.currentUser;
  return user?.uid ?? kFallbackUserId;
}