// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // //
// // // class UserLookupService {
// // //   final _db = FirebaseFirestore.instance;
// // //
// // //   Future<String?> findUserUidByEmail(String email) async {
// // //     final snap = await _db.collection('users').where('email', isEqualTo: email).limit(1).get();
// // //     if (snap.docs.isEmpty) return null;
// // //     return snap.docs.first.id; // doc.id is uid
// // //   }
// // //
// // //   Future<String?> findUserUidByUsername(String username) async {
// // //     final snap = await _db.collection('users').where('username', isEqualTo: username).limit(1).get();
// // //     if (snap.docs.isEmpty) return null;
// // //     return snap.docs.first.id;
// // //   }
// // // }
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class UserLookupService {
// //   final _db = FirebaseFirestore.instance;
// //
// //   Future<String?> findUserUidByEmail(String email) async {
// //     final snap = await _db.collection('users').where('email', isEqualTo: email).limit(1).get();
// //     if (snap.docs.isEmpty) return null;
// //     return snap.docs.first.id; // doc.id is uid
// //   }
// //
// //   Future<String?> findUserUidByUsername(String username) async {
// //     final snap = await _db.collection('users').where('username', isEqualTo: username).limit(1).get();
// //     if (snap.docs.isEmpty) return null;
// //     return snap.docs.first.id;
// //   }
// // }
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class UserLookupService {
//   final _db = FirebaseFirestore.instance;
//
//   Future<String?> findUserUidByEmail(String email) async {
//     final snap = await _db.collection('users').where('email', isEqualTo: email).limit(1).get();
//     if (snap.docs.isEmpty) return null;
//     return snap.docs.first.id; // doc.id is uid
//   }
//
//   Future<String?> findUserUidByUsername(String username) async {
//     final snap = await _db.collection('users').where('username', isEqualTo: username).limit(1).get();
//     if (snap.docs.isEmpty) return null;
//     return snap.docs.first.id;
//   }
// }