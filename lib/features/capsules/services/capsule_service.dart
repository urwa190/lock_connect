// // // // import 'dart:io';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import '../models/capsule.dart';
// // // // import '../models/capsule_content.dart';
// // // // import 'cloudinary_upload.dart';
// // // //
// // // // class CapsuleService {
// // // //   final _db = FirebaseFirestore.instance;
// // // //   final CloudinaryUploader uploader;
// // // //
// // // //   CapsuleService({required this.uploader});
// // // //
// // // //   Future<String> createCapsule(Capsule capsule, {File? coverFile}) async {
// // // //     final doc = _db.collection('capsules').doc();
// // // //     String coverUrl = '';
// // // //     if (coverFile != null) {
// // // //       coverUrl = await uploader.uploadImage(coverFile);
// // // //     }
// // // //     await doc.set({
// // // //       ...capsule.toJson(),
// // // //       'id': doc.id,
// // // //       'coverImageUrl': coverUrl,
// // // //       'createdAt': FieldValue.serverTimestamp(),
// // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // //     });
// // // //     return doc.id;
// // // //   }
// // // //
// // // //   Stream<List<Capsule>> streamCapsulesForUser(String uid) {
// // // //     return _db
// // // //         .collection('capsules')
// // // //         .where(Filter.or(
// // // //       Filter('ownerId', isEqualTo: uid),
// // // //       Filter('collaborators', arrayContains: uid),
// // // //     ))
// // // //         .orderBy('updatedAt', descending: true)
// // // //         .snapshots()
// // // //         .map((snap) => snap.docs.map((d) => Capsule.fromJson(d.data())).toList());
// // // //   }
// // // //
// // // //   Stream<Capsule> streamCapsule(String id) {
// // // //     return _db.collection('capsules').doc(id).snapshots().map((d) => Capsule.fromJson(d.data()!));
// // // //   }
// // // //
// // // //   Stream<List<CapsuleContent>> streamContents(String capsuleId) {
// // // //     return _db
// // // //         .collection('capsules')
// // // //         .doc(capsuleId)
// // // //         .collection('contents')
// // // //         .orderBy('createdAt', descending: true)
// // // //         .snapshots()
// // // //         .map((snap) => snap.docs.map((d) => CapsuleContent.fromJson(d.data())).toList());
// // // //   }
// // // //
// // // //   Future<void> addTextContent(String capsuleId, String text, String uid) async {
// // // //     final doc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// // // //     await doc.set({
// // // //       'id': doc.id,
// // // //       'type': 'text',
// // // //       'text': text,
// // // //       'createdBy': uid,
// // // //       'createdAt': FieldValue.serverTimestamp(),
// // // //     });
// // // //     await _db.collection('capsules').doc(capsuleId)
// // // //         .update({'updatedAt': FieldValue.serverTimestamp()});
// // // //   }
// // // //
// // // //   Future<void> addMediaContent(String capsuleId, File file, String type, String uid) async {
// // // //     final contentDoc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// // // //     final url = await uploader.uploadImage(file); // use video/upload if adding video support
// // // //     await contentDoc.set({
// // // //       'id': contentDoc.id,
// // // //       'type': type,           // 'image' (or 'video' if you add that)
// // // //       'storagePath': url,     // Cloudinary URL
// // // //       'createdBy': uid,
// // // //       'createdAt': FieldValue.serverTimestamp(),
// // // //     });
// // // //     await _db.collection('capsules').doc(capsuleId)
// // // //         .update({'updatedAt': FieldValue.serverTimestamp()});
// // // //   }
// // // //
// // // //   Future<void> updateCapsule(Capsule capsule) async {
// // // //     await _db.collection('capsules').doc(capsule.id).update({
// // // //       ...capsule.toJson(),
// // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // //     });
// // // //   }
// // // //
// // // //   Future<void> deleteCapsule(String id) async {
// // // //     await _db.collection('capsules').doc(id).delete();
// // // //   }
// // // //
// // // //   Future<void> removeCollaborator(String capsuleId, String uid) async {
// // // //     await _db.collection('capsules').doc(capsuleId).update({
// // // //       'collaborators': FieldValue.arrayRemove([uid]),
// // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // //     });
// // // //   }
// // // // }
// // //
// // // import 'dart:io';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import '../models/capsule.dart';
// // // import '../models/capsule_content.dart';
// // // import 'cloudinary_upload.dart';
// // // import 'package:lock_connect/utils/fallback_user.dart';
// // //
// // // class CapsuleService {
// // //   final _db = FirebaseFirestore.instance;
// // //   final CloudinaryUploader uploader;
// // //   final String userId;
// // //
// // //   CapsuleService({
// // //     required this.uploader,
// // //     String? userId,
// // //   }) : userId = userId ?? currentUserIdOrFallback();
// // //
// // //   Future<String> createCapsule(Capsule capsule, {File? coverFile}) async {
// // //     final doc = _db.collection('capsules').doc();
// // //     String coverUrl = '';
// // //     if (coverFile != null) {
// // //       coverUrl = await uploader.uploadImage(coverFile);
// // //     }
// // //     await doc.set({
// // //       ...capsule.toJson(),
// // //       'id': doc.id,
// // //       'ownerId': capsule.ownerId.isNotEmpty ? capsule.ownerId : userId,
// // //       'coverImageUrl': coverUrl,
// // //       'createdAt': FieldValue.serverTimestamp(),
// // //       'updatedAt': FieldValue.serverTimestamp(),
// // //     });
// // //     return doc.id;
// // //   }
// // //
// // //   Stream<List<Capsule>> streamCapsulesForUser([String? uid]) {
// // //     final effectiveUid = uid ?? userId;
// // //     return _db
// // //         .collection('capsules')
// // //         .where(Filter.or(
// // //       Filter('ownerId', isEqualTo: effectiveUid),
// // //       Filter('collaborators', arrayContains: effectiveUid),
// // //     ))
// // //         .orderBy('updatedAt', descending: true)
// // //         .snapshots()
// // //         .map((snap) => snap.docs.map((d) => Capsule.fromJson(d.data())).toList());
// // //   }
// // //
// // //   Stream<Capsule> streamCapsule(String id) {
// // //     return _db.collection('capsules').doc(id).snapshots().map((d) => Capsule.fromJson(d.data()!));
// // //   }
// // //
// // //   Stream<List<CapsuleContent>> streamContents(String capsuleId) {
// // //     return _db
// // //         .collection('capsules')
// // //         .doc(capsuleId)
// // //         .collection('contents')
// // //         .orderBy('createdAt', descending: true)
// // //         .snapshots()
// // //         .map((snap) => snap.docs.map((d) => CapsuleContent.fromJson(d.data())).toList());
// // //   }
// // //
// // //   Future<void> addTextContent(String capsuleId, String text, {String? uid}) async {
// // //     final effectiveUid = uid ?? userId;
// // //     final doc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// // //     await doc.set({
// // //       'id': doc.id,
// // //       'type': 'text',
// // //       'text': text,
// // //       'createdBy': effectiveUid,
// // //       'createdAt': FieldValue.serverTimestamp(),
// // //     });
// // //     await _db.collection('capsules').doc(capsuleId)
// // //         .update({'updatedAt': FieldValue.serverTimestamp()});
// // //   }
// // //
// // //   Future<void> addMediaContent(String capsuleId, File file, String type, {String? uid}) async {
// // //     final effectiveUid = uid ?? userId;
// // //     final contentDoc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// // //     final url = await uploader.uploadImage(file); // use video/upload if adding video support
// // //     await contentDoc.set({
// // //       'id': contentDoc.id,
// // //       'type': type,           // 'image' (or 'video' if you add that)
// // //       'storagePath': url,     // Cloudinary URL
// // //       'createdBy': effectiveUid,
// // //       'createdAt': FieldValue.serverTimestamp(),
// // //     });
// // //     await _db.collection('capsules').doc(capsuleId)
// // //         .update({'updatedAt': FieldValue.serverTimestamp()});
// // //   }
// // //
// // //   Future<void> updateCapsule(Capsule capsule) async {
// // //     await _db.collection('capsules').doc(capsule.id).update({
// // //       ...capsule.toJson(),
// // //       'ownerId': capsule.ownerId.isNotEmpty ? capsule.ownerId : userId,
// // //       'updatedAt': FieldValue.serverTimestamp(),
// // //     });
// // //   }
// // //
// // //   Future<void> deleteCapsule(String id) async {
// // //     await _db.collection('capsules').doc(id).delete();
// // //   }
// // //
// // //   Future<void> removeCollaborator(String capsuleId, {String? uid}) async {
// // //     final effectiveUid = uid ?? userId;
// // //     await _db.collection('capsules').doc(capsuleId).update({
// // //       'collaborators': FieldValue.arrayRemove([effectiveUid]),
// // //       'updatedAt': FieldValue.serverTimestamp(),
// // //     });
// // //   }
// // // }
// //
// //
// // import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import '../models/capsule.dart';
// // import '../models/capsule_content.dart';
// // import 'cloudinary_upload.dart';
// //
// // class CapsuleService {
// //   final _db = FirebaseFirestore.instance;
// //   final CloudinaryUploader uploader;
// //
// //   CapsuleService({required this.uploader});
// //
// //   Future<String> createCapsule(Capsule capsule, {File? coverFile}) async {
// //     final doc = _db.collection('capsules').doc();
// //     String coverUrl = '';
// //     if (coverFile != null) {
// //       coverUrl = await uploader.uploadImage(coverFile);
// //     }
// //     await doc.set({
// //       ...capsule.toJson(),
// //       'id': doc.id,
// //       'coverImageUrl': coverUrl,
// //       'createdAt': FieldValue.serverTimestamp(),
// //       'updatedAt': FieldValue.serverTimestamp(),
// //     });
// //     return doc.id;
// //   }
// //
// //   Stream<List<Capsule>> streamCapsulesForUser(String uid) {
// //     return _db
// //         .collection('capsules')
// //         .where(Filter.or(
// //       Filter('ownerId', isEqualTo: uid),
// //       Filter('collaborators', arrayContains: uid),
// //     ))
// //         .orderBy('updatedAt', descending: true)
// //         .snapshots()
// //         .map((snap) => snap.docs.map((d) => Capsule.fromJson(d.data())).toList());
// //   }
// //
// //   Stream<Capsule> streamCapsule(String id) {
// //     return _db.collection('capsules').doc(id).snapshots().map((d) => Capsule.fromJson(d.data()!));
// //   }
// //
// //   Stream<List<CapsuleContent>> streamContents(String capsuleId) {
// //     return _db
// //         .collection('capsules')
// //         .doc(capsuleId)
// //         .collection('contents')
// //         .orderBy('createdAt', descending: true)
// //         .snapshots()
// //         .map((snap) => snap.docs.map((d) => CapsuleContent.fromJson(d.data())).toList());
// //   }
// //
// //   Future<void> addTextContent(String capsuleId, String text, String uid) async {
// //     final doc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// //     await doc.set({
// //       'id': doc.id,
// //       'type': 'text',
// //       'text': text,
// //       'createdBy': uid,
// //       'createdAt': FieldValue.serverTimestamp(),
// //     });
// //     await _db.collection('capsules').doc(capsuleId)
// //         .update({'updatedAt': FieldValue.serverTimestamp()});
// //   }
// //
// //   Future<void> addMediaContent(String capsuleId, File file, String type, String uid) async {
// //     final contentDoc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// //     final url = await uploader.uploadImage(file); // use video/upload if adding video support
// //     await contentDoc.set({
// //       'id': contentDoc.id,
// //       'type': type,           // 'image' (or 'video' if you add that)
// //       'storagePath': url,     // Cloudinary URL
// //       'createdBy': uid,
// //       'createdAt': FieldValue.serverTimestamp(),
// //     });
// //     await _db.collection('capsules').doc(capsuleId)
// //         .update({'updatedAt': FieldValue.serverTimestamp()});
// //   }
// //
// //   Future<void> updateCapsule(Capsule capsule) async {
// //     await _db.collection('capsules').doc(capsule.id).update({
// //       ...capsule.toJson(),
// //       'updatedAt': FieldValue.serverTimestamp(),
// //     });
// //   }
// //
// //   Future<void> deleteCapsule(String id) async {
// //     await _db.collection('capsules').doc(id).delete();
// //   }
// //
// //   Future<void> removeCollaborator(String capsuleId, String uid) async {
// //     await _db.collection('capsules').doc(capsuleId).update({
// //       'collaborators': FieldValue.arrayRemove([uid]),
// //       'updatedAt': FieldValue.serverTimestamp(),
// //     });
// //   }
// // }
//
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class CloudinaryUploader {
//   final String cloudName;
//   final String uploadPreset;
//
//   CloudinaryUploader({required this.cloudName, required this.uploadPreset});
//
//   Future<String> uploadImage(File file) async {
//     final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload');
//     final request = http.MultipartRequest('POST', url)
//       ..fields['upload_preset'] = uploadPreset
//       ..files.add(await http.MultipartFile.fromPath('file', file.path));
//
//     final response = await request.send();
//     if (response.statusCode == 200) {
//       final responseData = await response.stream.bytesToString();
//       return jsonDecode(responseData)['secure_url'];
//     } else {
//       throw Exception('Cloudinary upload failed');
//     }
//   }
// }


import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/capsule.dart';
import 'cloudinary_upload.dart';

class CapsuleService {
  final _db = FirebaseFirestore.instance;
  final CloudinaryUploader uploader;

  CapsuleService({required this.uploader});

  Future<String> createCapsule(Capsule capsule, {File? coverFile}) async {
    final doc = _db.collection('capsules').doc();
    String coverUrl = '';

    if (coverFile != null) {
      coverUrl = await uploader.uploadImage(coverFile);
    }

    // Using .toJson() ensures all fields like isLocked and updatedAt are saved
    await doc.set({
      ...capsule.toJson(),
      'id': doc.id,
      'coverImageUrl': coverUrl,
    });
    return doc.id;
  }

  Future<void> addTextContent(String capsuleId, String text, String uid) async {
    await _db.collection('capsules').doc(capsuleId).collection('contents').add({
      'type': 'text',
      'text': text,
      'createdBy': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}