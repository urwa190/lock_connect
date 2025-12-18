// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import '../models/collab_request.dart';
// // //
// // // class CollaborationService {
// // //   final _db = FirebaseFirestore.instance;
// // //
// // //   Future<void> sendRequest({
// // //     required String capsuleId,
// // //     required String fromUid,
// // //     required String toUid,
// // //   }) async {
// // //     final doc = _db.collection('collaborationRequests').doc();
// // //     await doc.set({
// // //       'id': doc.id,
// // //       'capsuleId': capsuleId,
// // //       'fromUid': fromUid,
// // //       'toUid': toUid,
// // //       'status': 'pending',
// // //       'createdAt': FieldValue.serverTimestamp(),
// // //       'updatedAt': FieldValue.serverTimestamp(),
// // //     });
// // //   }
// // //
// // //   Stream<List<CollabRequest>> streamIncoming(String toUid) {
// // //     return _db
// // //         .collection('collaborationRequests')
// // //         .where('toUid', isEqualTo: toUid)
// // //         .where('status', isEqualTo: 'pending')
// // //         .snapshots()
// // //         .map((s) => s.docs.map((d) => CollabRequest.fromJson(d.data())).toList());
// // //   }
// // //
// // //   Future<void> respondRequest({required String requestId, required bool accept}) async {
// // //     final doc = _db.collection('collaborationRequests').doc(requestId);
// // //     final snap = await doc.get();
// // //     final data = snap.data()!;
// // //     if (accept) {
// // //       final capRef = _db.collection('capsules').doc(data['capsuleId']);
// // //       await capRef.update({
// // //         'collaborators': FieldValue.arrayUnion([data['fromUid']]),
// // //         'updatedAt': FieldValue.serverTimestamp(),
// // //       });
// // //       await doc.update({'status': 'accepted', 'updatedAt': FieldValue.serverTimestamp()});
// // //     } else {
// // //       await doc.update({'status': 'rejected', 'updatedAt': FieldValue.serverTimestamp()});
// // //     }
// // //   }
// // // }
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:lock_connect/utils/fallback_user.dart';
// //
// // import '../models/collab_request.dart';
// //
// // class CollaborationService {
// //   final _db = FirebaseFirestore.instance;
// //
// //   Future<void> sendRequest({
// //     required String capsuleId,
// //     String? fromUid, // optional; defaults to current user (fallback-aware)
// //     required String toUid,
// //   }) async {
// //     final effectiveFrom = fromUid ?? currentUserIdOrFallback();
// //     final doc = _db.collection('collaborationRequests').doc();
// //     await doc.set({
// //       'id': doc.id,
// //       'capsuleId': capsuleId,
// //       'fromUid': effectiveFrom,
// //       'toUid': toUid,
// //       'status': 'pending',
// //       'createdAt': FieldValue.serverTimestamp(),
// //       'updatedAt': FieldValue.serverTimestamp(),
// //     });
// //   }
// //
// //   Stream<List<CollabRequest>> streamIncoming({String? toUid}) {
// //     final effectiveTo = toUid ?? currentUserIdOrFallback();
// //     return _db
// //         .collection('collaborationRequests')
// //         .where('toUid', isEqualTo: effectiveTo)
// //         .where('status', isEqualTo: 'pending')
// //         .snapshots()
// //         .map((s) => s.docs.map((d) => CollabRequest.fromJson(d.data())).toList());
// //   }
// //
// //   Future<void> respondRequest({required String requestId, required bool accept}) async {
// //     final doc = _db.collection('collaborationRequests').doc(requestId);
// //     final snap = await doc.get();
// //     final data = snap.data()!;
// //     if (accept) {
// //       final capRef = _db.collection('capsules').doc(data['capsuleId']);
// //       await capRef.update({
// //         'collaborators': FieldValue.arrayUnion([data['fromUid']]),
// //         'updatedAt': FieldValue.serverTimestamp(),
// //       });
// //       await doc.update({'status': 'accepted', 'updatedAt': FieldValue.serverTimestamp()});
// //     } else {
// //       await doc.update({'status': 'rejected', 'updatedAt': FieldValue.serverTimestamp()});
// //     }
// //   }
// // }
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/collab_request.dart';
//
// class CollaborationService {
//   final _db = FirebaseFirestore.instance;
//
//   Future<void> sendRequest({
//     required String capsuleId,
//     required String fromUid,
//     required String toUid,
//   }) async {
//     final doc = _db.collection('collaborationRequests').doc();
//     await doc.set({
//       'id': doc.id,
//       'capsuleId': capsuleId,
//       'fromUid': fromUid,
//       'toUid': toUid,
//       'status': 'pending',
//       'createdAt': FieldValue.serverTimestamp(),
//       'updatedAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//   Stream<List<CollabRequest>> streamIncoming(String toUid) {
//     return _db
//         .collection('collaborationRequests')
//         .where('toUid', isEqualTo: toUid)
//         .where('status', isEqualTo: 'pending')
//         .snapshots()
//         .map((s) => s.docs.map((d) => CollabRequest.fromJson(d.data())).toList());
//   }
//
//   Future<void> respondRequest({required String requestId, required bool accept}) async {
//     final doc = _db.collection('collaborationRequests').doc(requestId);
//     final snap = await doc.get();
//     final data = snap.data()!;
//     if (accept) {
//       final capRef = _db.collection('capsules').doc(data['capsuleId']);
//       await capRef.update({
//         'collaborators': FieldValue.arrayUnion([data['fromUid']]),
//         'updatedAt': FieldValue.serverTimestamp(),
//       });
//       await doc.update({'status': 'accepted', 'updatedAt': FieldValue.serverTimestamp()});
//     } else {
//       await doc.update({'status': 'rejected', 'updatedAt': FieldValue.serverTimestamp()});
//     }
//   }
// }