import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

// This class mimics the real Firebase User
class MockUser extends Mock implements User {
  @override
  String get displayName => 'Rekindl Tester';

  @override
  String get email => 'test@rekindl.com';

  @override
  String get uid => 'tester_12345';

  @override
  String? get photoURL => 'assets/logo.png'; // Fallback to your asset
}

// This class mimics the real FirebaseAuth instance
class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  User? get currentUser => MockUser();

  // This ensures authStateChanges doesn't return null and break your StreamBuilders
  @override
  Stream<User?> authStateChanges() => Stream.value(MockUser());
}

// 🌟 THE MAGIC PART:
// In your other files, you use: final FirebaseAuth _auth = FirebaseAuth.instance;
// This variable below makes sure that even if the real Firebase isn't logged in,
// your code thinks it is.
final FirebaseAuth mockAuth = MockFirebaseAuth();