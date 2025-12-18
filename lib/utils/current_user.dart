import 'package:firebase_auth/firebase_auth.dart';

/// Throws if not signed in. Use when you expect a logged-in user.
String requireUid() {
  final u = FirebaseAuth.instance.currentUser;
  if (u == null) {
    throw FirebaseAuthException(
      code: 'not-signed-in',
      message: 'User must be signed in.',
    );
  }
  return u.uid;
}