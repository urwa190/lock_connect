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

const String kFirebaseApiKey = String.fromEnvironment('FIREBASE_API_KEY');
const String kFirebaseAppId = String.fromEnvironment('FIREBASE_APP_ID');
const String kFirebaseMessagingSenderId =
    String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
const String kFirebaseProjectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
const String kFirebaseStorageBucket = String.fromEnvironment('FIREBASE_STORAGE_BUCKET');

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: kFirebaseApiKey,
        appId: kFirebaseAppId,
        messagingSenderId: kFirebaseMessagingSenderId,
        projectId: kFirebaseProjectId,
        storageBucket: kFirebaseStorageBucket,
      );
    }
    throw UnsupportedError('DefaultFirebaseOptions are only set up for Android.');
  }
}