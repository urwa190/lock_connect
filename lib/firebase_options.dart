// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
//
// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       return const FirebaseOptions(
//         apiKey: "AIzaSyACT4ZRpLmEVGkAeL8Yzug4Yph_a76jP1Y",
//         appId: "1:376637785492:android:27f7ca3fdef52e9bb8fb81",
//         messagingSenderId: "376637785492",
//         projectId: "lock-connect",
//         storageBucket: "lock-connect.firebasestorage.app",
//       );
//     }
//     throw UnsupportedError('DefaultFirebaseOptions are only set up for Android.');
//   }
// }


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: "AIzaSyACT4ZRpLmEVGkAeL8Yzug4Yph_a76jP1Y",
        appId: "1:376637785492:android:27f7ca3fdef52e9bb8fb81",
        messagingSenderId: "376637785492",
        projectId: "lock-connect",
        storageBucket: "lock-connect.firebasestorage.app",
      );
    }
    throw UnsupportedError('DefaultFirebaseOptions are only set up for Android.');
  }
}