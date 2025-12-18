import 'package:firebase_auth/firebase_auth.dart';

/// Temporary fallback while auth is not ready.
/// Replace the const below when real sign-in is active.
const String kFallbackUserId =
    String.fromEnvironment('FALLBACK_USER_ID', defaultValue: '');

String currentUserIdOrFallback() {
  final user = FirebaseAuth.instance.currentUser;
  return user?.uid ?? kFallbackUserId;
}