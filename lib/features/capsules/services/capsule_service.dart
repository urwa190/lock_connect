// // // // // // // // import 'dart:io';
// // // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // // // import '../models/capsule.dart';
// // // // // // // // import '../models/capsule_content.dart';
// // // // // // // // import 'cloudinary_upload.dart';
// // // // // // // //
// // // // // // // // class CapsuleService {
// // // // // // // //   final _db = FirebaseFirestore.instance;
// // // // // // // //   final CloudinaryUploader uploader;
// // // // // // // //
// // // // // // // //   CapsuleService({required this.uploader});
// // // // // // // //
// // // // // // // //   Future<String> createCapsule(Capsule capsule, {File? coverFile}) async {
// // // // // // // //     final doc = _db.collection('capsules').doc();
// // // // // // // //     String coverUrl = '';
// // // // // // // //     if (coverFile != null) {
// // // // // // // //       coverUrl = await uploader.uploadImage(coverFile);
// // // // // // // //     }
// // // // // // // //     await doc.set({
// // // // // // // //       ...capsule.toJson(),
// // // // // // // //       'id': doc.id,
// // // // // // // //       'coverImageUrl': coverUrl,
// // // // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // // // // // //     });
// // // // // // // //     return doc.id;
// // // // // // // //   }
// // // // // // // //
// // // // // // // //   Stream<List<Capsule>> streamCapsulesForUser(String uid) {
// // // // // // // //     return _db
// // // // // // // //         .collection('capsules')
// // // // // // // //         .where(Filter.or(
// // // // // // // //       Filter('ownerId', isEqualTo: uid),
// // // // // // // //       Filter('collaborators', arrayContains: uid),
// // // // // // // //     ))
// // // // // // // //         .orderBy('updatedAt', descending: true)
// // // // // // // //         .snapshots()
// // // // // // // //         .map((snap) => snap.docs.map((d) => Capsule.fromJson(d.data())).toList());
// // // // // // // //   }
// // // // // // // //
// // // // // // // //   Stream<Capsule> streamCapsule(String id) {
// // // // // // // //     return _db.collection('capsules').doc(id).snapshots().map((d) => Capsule.fromJson(d.data()!));
// // // // // // // //   }
// // // // // // // //
// // // // // // // //   Stream<List<CapsuleContent>> streamContents(String capsuleId) {
// // // // // // // //     return _db
// // // // // // // //         .collection('capsules')
// // // // // // // //         .doc(capsuleId)
// // // // // // // //         .collection('contents')
// // // // // // // //         .orderBy('createdAt', descending: true)
// // // // // // // //         .snapshots()
// // // // // // // //         .map((snap) => snap.docs.map((d) => CapsuleContent.fromJson(d.data())).toList());
// // // // // // // //   }
// // // // // // // //
// // // // // // // //   Future<void> addTextContent(String capsuleId, String text, String uid) async {
// // // // // // // //     final doc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// // // // // // // //     await doc.set({
// // // // // // // //       'id': doc.id,
// // // // // // // //       'type': 'text',
// // // // // // // //       'text': text,
// // // // // // // //       'createdBy': uid,
// // // // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // // // //     });
// // // // // // // //     await _db.collection('capsules').doc(capsuleId)
// // // // // // // //         .update({'updatedAt': FieldValue.serverTimestamp()});
// // // // // // // //   }
// // // // // // // //
// // // // // // // //   Future<void> addMediaContent(String capsuleId, File file, String type, String uid) async {
// // // // // // // //     final contentDoc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// // // // // // // //     final url = await uploader.uploadImage(file); // use video/upload if adding video support
// // // // // // // //     await contentDoc.set({
// // // // // // // //       'id': contentDoc.id,
// // // // // // // //       'type': type,           // 'image' (or 'video' if you add that)
// // // // // // // //       'storagePath': url,     // Cloudinary URL
// // // // // // // //       'createdBy': uid,
// // // // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // // // //     });
// // // // // // // //     await _db.collection('capsules').doc(capsuleId)
// // // // // // // //         .update({'updatedAt': FieldValue.serverTimestamp()});
// // // // // // // //   }
// // // // // // // //
// // // // // // // //   Future<void> updateCapsule(Capsule capsule) async {
// // // // // // // //     await _db.collection('capsules').doc(capsule.id).update({
// // // // // // // //       ...capsule.toJson(),
// // // // // // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // // // // // //     });
// // // // // // // //   }
// // // // // // // //
// // // // // // // //   Future<void> deleteCapsule(String id) async {
// // // // // // // //     await _db.collection('capsules').doc(id).delete();
// // // // // // // //   }
// // // // // // // //
// // // // // // // //   Future<void> removeCollaborator(String capsuleId, String uid) async {
// // // // // // // //     await _db.collection('capsules').doc(capsuleId).update({
// // // // // // // //       'collaborators': FieldValue.arrayRemove([uid]),
// // // // // // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // // // // // //     });
// // // // // // // //   }
// // // // // // // // }
// // // // // // //
// // // // // // // import 'dart:io';
// // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // // import '../models/capsule.dart';
// // // // // // // import '../models/capsule_content.dart';
// // // // // // // import 'cloudinary_upload.dart';
// // // // // // // import 'package:lock_connect/utils/fallback_user.dart';
// // // // // // //
// // // // // // // class CapsuleService {
// // // // // // //   final _db = FirebaseFirestore.instance;
// // // // // // //   final CloudinaryUploader uploader;
// // // // // // //   final String userId;
// // // // // // //
// // // // // // //   CapsuleService({
// // // // // // //     required this.uploader,
// // // // // // //     String? userId,
// // // // // // //   }) : userId = userId ?? currentUserIdOrFallback();
// // // // // // //
// // // // // // //   Future<String> createCapsule(Capsule capsule, {File? coverFile}) async {
// // // // // // //     final doc = _db.collection('capsules').doc();
// // // // // // //     String coverUrl = '';
// // // // // // //     if (coverFile != null) {
// // // // // // //       coverUrl = await uploader.uploadImage(coverFile);
// // // // // // //     }
// // // // // // //     await doc.set({
// // // // // // //       ...capsule.toJson(),
// // // // // // //       'id': doc.id,
// // // // // // //       'ownerId': capsule.ownerId.isNotEmpty ? capsule.ownerId : userId,
// // // // // // //       'coverImageUrl': coverUrl,
// // // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // // // // //     });
// // // // // // //     return doc.id;
// // // // // // //   }
// // // // // // //
// // // // // // //   Stream<List<Capsule>> streamCapsulesForUser([String? uid]) {
// // // // // // //     final effectiveUid = uid ?? userId;
// // // // // // //     return _db
// // // // // // //         .collection('capsules')
// // // // // // //         .where(Filter.or(
// // // // // // //       Filter('ownerId', isEqualTo: effectiveUid),
// // // // // // //       Filter('collaborators', arrayContains: effectiveUid),
// // // // // // //     ))
// // // // // // //         .orderBy('updatedAt', descending: true)
// // // // // // //         .snapshots()
// // // // // // //         .map((snap) => snap.docs.map((d) => Capsule.fromJson(d.data())).toList());
// // // // // // //   }
// // // // // // //
// // // // // // //   Stream<Capsule> streamCapsule(String id) {
// // // // // // //     return _db.collection('capsules').doc(id).snapshots().map((d) => Capsule.fromJson(d.data()!));
// // // // // // //   }
// // // // // // //
// // // // // // //   Stream<List<CapsuleContent>> streamContents(String capsuleId) {
// // // // // // //     return _db
// // // // // // //         .collection('capsules')
// // // // // // //         .doc(capsuleId)
// // // // // // //         .collection('contents')
// // // // // // //         .orderBy('createdAt', descending: true)
// // // // // // //         .snapshots()
// // // // // // //         .map((snap) => snap.docs.map((d) => CapsuleContent.fromJson(d.data())).toList());
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> addTextContent(String capsuleId, String text, {String? uid}) async {
// // // // // // //     final effectiveUid = uid ?? userId;
// // // // // // //     final doc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// // // // // // //     await doc.set({
// // // // // // //       'id': doc.id,
// // // // // // //       'type': 'text',
// // // // // // //       'text': text,
// // // // // // //       'createdBy': effectiveUid,
// // // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // // //     });
// // // // // // //     await _db.collection('capsules').doc(capsuleId)
// // // // // // //         .update({'updatedAt': FieldValue.serverTimestamp()});
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> addMediaContent(String capsuleId, File file, String type, {String? uid}) async {
// // // // // // //     final effectiveUid = uid ?? userId;
// // // // // // //     final contentDoc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// // // // // // //     final url = await uploader.uploadImage(file); // use video/upload if adding video support
// // // // // // //     await contentDoc.set({
// // // // // // //       'id': contentDoc.id,
// // // // // // //       'type': type,           // 'image' (or 'video' if you add that)
// // // // // // //       'storagePath': url,     // Cloudinary URL
// // // // // // //       'createdBy': effectiveUid,
// // // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // // //     });
// // // // // // //     await _db.collection('capsules').doc(capsuleId)
// // // // // // //         .update({'updatedAt': FieldValue.serverTimestamp()});
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> updateCapsule(Capsule capsule) async {
// // // // // // //     await _db.collection('capsules').doc(capsule.id).update({
// // // // // // //       ...capsule.toJson(),
// // // // // // //       'ownerId': capsule.ownerId.isNotEmpty ? capsule.ownerId : userId,
// // // // // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // // // // //     });
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> deleteCapsule(String id) async {
// // // // // // //     await _db.collection('capsules').doc(id).delete();
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> removeCollaborator(String capsuleId, {String? uid}) async {
// // // // // // //     final effectiveUid = uid ?? userId;
// // // // // // //     await _db.collection('capsules').doc(capsuleId).update({
// // // // // // //       'collaborators': FieldValue.arrayRemove([effectiveUid]),
// // // // // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // // // // //     });
// // // // // // //   }
// // // // // // // }
// // // // // //
// // // // // //
// // // // // // import 'dart:io';
// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // import '../models/capsule.dart';
// // // // // // import '../models/capsule_content.dart';
// // // // // // import 'cloudinary_upload.dart';
// // // // // //
// // // // // // class CapsuleService {
// // // // // //   final _db = FirebaseFirestore.instance;
// // // // // //   final CloudinaryUploader uploader;
// // // // // //
// // // // // //   CapsuleService({required this.uploader});
// // // // // //
// // // // // //   Future<String> createCapsule(Capsule capsule, {File? coverFile}) async {
// // // // // //     final doc = _db.collection('capsules').doc();
// // // // // //     String coverUrl = '';
// // // // // //     if (coverFile != null) {
// // // // // //       coverUrl = await uploader.uploadImage(coverFile);
// // // // // //     }
// // // // // //     await doc.set({
// // // // // //       ...capsule.toJson(),
// // // // // //       'id': doc.id,
// // // // // //       'coverImageUrl': coverUrl,
// // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // // // //     });
// // // // // //     return doc.id;
// // // // // //   }
// // // // // //
// // // // // //   Stream<List<Capsule>> streamCapsulesForUser(String uid) {
// // // // // //     return _db
// // // // // //         .collection('capsules')
// // // // // //         .where(Filter.or(
// // // // // //       Filter('ownerId', isEqualTo: uid),
// // // // // //       Filter('collaborators', arrayContains: uid),
// // // // // //     ))
// // // // // //         .orderBy('updatedAt', descending: true)
// // // // // //         .snapshots()
// // // // // //         .map((snap) => snap.docs.map((d) => Capsule.fromJson(d.data())).toList());
// // // // // //   }
// // // // // //
// // // // // //   Stream<Capsule> streamCapsule(String id) {
// // // // // //     return _db.collection('capsules').doc(id).snapshots().map((d) => Capsule.fromJson(d.data()!));
// // // // // //   }
// // // // // //
// // // // // //   Stream<List<CapsuleContent>> streamContents(String capsuleId) {
// // // // // //     return _db
// // // // // //         .collection('capsules')
// // // // // //         .doc(capsuleId)
// // // // // //         .collection('contents')
// // // // // //         .orderBy('createdAt', descending: true)
// // // // // //         .snapshots()
// // // // // //         .map((snap) => snap.docs.map((d) => CapsuleContent.fromJson(d.data())).toList());
// // // // // //   }
// // // // // //
// // // // // //   Future<void> addTextContent(String capsuleId, String text, String uid) async {
// // // // // //     final doc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// // // // // //     await doc.set({
// // // // // //       'id': doc.id,
// // // // // //       'type': 'text',
// // // // // //       'text': text,
// // // // // //       'createdBy': uid,
// // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // //     });
// // // // // //     await _db.collection('capsules').doc(capsuleId)
// // // // // //         .update({'updatedAt': FieldValue.serverTimestamp()});
// // // // // //   }
// // // // // //
// // // // // //   Future<void> addMediaContent(String capsuleId, File file, String type, String uid) async {
// // // // // //     final contentDoc = _db.collection('capsules').doc(capsuleId).collection('contents').doc();
// // // // // //     final url = await uploader.uploadImage(file); // use video/upload if adding video support
// // // // // //     await contentDoc.set({
// // // // // //       'id': contentDoc.id,
// // // // // //       'type': type,           // 'image' (or 'video' if you add that)
// // // // // //       'storagePath': url,     // Cloudinary URL
// // // // // //       'createdBy': uid,
// // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // //     });
// // // // // //     await _db.collection('capsules').doc(capsuleId)
// // // // // //         .update({'updatedAt': FieldValue.serverTimestamp()});
// // // // // //   }
// // // // // //
// // // // // //   Future<void> updateCapsule(Capsule capsule) async {
// // // // // //     await _db.collection('capsules').doc(capsule.id).update({
// // // // // //       ...capsule.toJson(),
// // // // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // // // //     });
// // // // // //   }
// // // // // //
// // // // // //   Future<void> deleteCapsule(String id) async {
// // // // // //     await _db.collection('capsules').doc(id).delete();
// // // // // //   }
// // // // // //
// // // // // //   Future<void> removeCollaborator(String capsuleId, String uid) async {
// // // // // //     await _db.collection('capsules').doc(capsuleId).update({
// // // // // //       'collaborators': FieldValue.arrayRemove([uid]),
// // // // // //       'updatedAt': FieldValue.serverTimestamp(),
// // // // // //     });
// // // // // //   }
// // // // // // }
// // // // //
// // // // // import 'dart:io';
// // // // // import 'package:http/http.dart' as http;
// // // // // import 'dart:convert';
// // // // //
// // // // // class CloudinaryUploader {
// // // // //   final String cloudName;
// // // // //   final String uploadPreset;
// // // // //
// // // // //   CloudinaryUploader({required this.cloudName, required this.uploadPreset});
// // // // //
// // // // //   Future<String> uploadImage(File file) async {
// // // // //     final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload');
// // // // //     final request = http.MultipartRequest('POST', url)
// // // // //       ..fields['upload_preset'] = uploadPreset
// // // // //       ..files.add(await http.MultipartFile.fromPath('file', file.path));
// // // // //
// // // // //     final response = await request.send();
// // // // //     if (response.statusCode == 200) {
// // // // //       final responseData = await response.stream.bytesToString();
// // // // //       return jsonDecode(responseData)['secure_url'];
// // // // //     } else {
// // // // //       throw Exception('Cloudinary upload failed');
// // // // //     }
// // // // //   }
// // // // // }
// // // //
// // // //
// // // // import 'dart:io';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import '../models/capsule.dart';
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
// // // //
// // // //     if (coverFile != null) {
// // // //       coverUrl = await uploader.uploadImage(coverFile);
// // // //     }
// // // //
// // // //     // Using .toJson() ensures all fields like isLocked and updatedAt are saved
// // // //     await doc.set({
// // // //       ...capsule.toJson(),
// // // //       'id': doc.id,
// // // //       'coverImageUrl': coverUrl,
// // // //     });
// // // //     return doc.id;
// // // //   }
// // // //
// // // //   Future<void> addTextContent(String capsuleId, String text, String uid) async {
// // // //     await _db.collection('capsules').doc(capsuleId).collection('contents').add({
// // // //       'type': 'text',
// // // //       'text': text,
// // // //       'createdBy': uid,
// // // //       'createdAt': FieldValue.serverTimestamp(),
// // // //     });
// // // //   }
// // // // }
// // //
// // // import 'dart:io';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import '../models/capsule.dart';
// // // import 'cloudinary_upload.dart';
// // //
// // // class CapsuleService {
// // //   final _db = FirebaseFirestore.instance;
// // //   final CloudinaryUploader uploader;
// // //
// // //   CapsuleService({required this.uploader});
// // //
// // //   Future<String> createCapsule(Capsule capsule) async {
// // //     final doc = _db.collection('capsules').doc();
// // //     // We remove the coverFile parameter logic here to focus on subcollections
// // //     await doc.set({
// // //       ...capsule.toJson(),
// // //       'id': doc.id,
// // //       'createdAt': FieldValue.serverTimestamp(),
// // //       'updatedAt': FieldValue.serverTimestamp(),
// // //     });
// // //     return doc.id;
// // //   }
// // //
// // //   // Method to add individual media items to the contents subcollection
// // //   Future<void> addMediaContent(String capsuleId, File file, String uid) async {
// // //     final String mediaUrl = await uploader.uploadImage(file);
// // //
// // //     await _db.collection('capsules').doc(capsuleId).collection('contents').add({
// // //       'type': 'image',
// // //       'mediaUrl': mediaUrl,
// // //       'createdBy': uid,
// // //       'createdAt': FieldValue.serverTimestamp(),
// // //     });
// // //
// // //     // Update the parent's timestamp for sorting purposes
// // //     await _db.collection('capsules').doc(capsuleId).update({
// // //       'updatedAt': FieldValue.serverTimestamp(),
// // //     });
// // //   }
// // //
// // //   Future<void> addTextContent(String capsuleId, String text, String uid) async {
// // //     await _db.collection('capsules').doc(capsuleId).collection('contents').add({
// // //       'type': 'text',
// // //       'text': text,
// // //       'createdBy': uid,
// // //       'createdAt': FieldValue.serverTimestamp(),
// // //     });
// // //   }
// // // }
// //
// // import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import '../models/capsule.dart';
// // import 'cloudinary_upload.dart';
// //
// // class CapsuleService {
// //   final _db = FirebaseFirestore.instance;
// //   final CloudinaryUploader uploader;
// //
// //   CapsuleService({required this.uploader});
// //
// //   // Creates the main capsule without a cover image
// //   Future<String> createCapsule(Capsule capsule) async {
// //     final doc = _db.collection('capsules').doc();
// //     await doc.set({
// //       ...capsule.toJson(),
// //       'id': doc.id,
// //       'coverImageUrl': '', // Explicitly empty as requested
// //       'createdAt': FieldValue.serverTimestamp(),
// //       'updatedAt': FieldValue.serverTimestamp(),
// //     });
// //     return doc.id;
// //   }
// //
// //   // Adds media items as individual documents in the subcollection
// //   Future<void> addMediaContent(String capsuleId, File file, String uid) async {
// //     final String mediaUrl = await uploader.uploadImage(file);
// //
// //     await _db.collection('capsules').doc(capsuleId).collection('contents').add({
// //       'type': 'image',
// //       'mediaUrl': mediaUrl,
// //       'createdBy': uid,
// //       'createdAt': FieldValue.serverTimestamp(),
// //     });
// //
// //     // Update parent document's updatedAt for list sorting
// //     await _db.collection('capsules').doc(capsuleId).update({
// //       'updatedAt': FieldValue.serverTimestamp(),
// //     });
// //   }
// //
// //   Future<void> addTextContent(String capsuleId, String text, String uid) async {
// //     await _db.collection('capsules').doc(capsuleId).collection('contents').add({
// //       'type': 'text',
// //       'text': text,
// //       'createdBy': uid,
// //       'createdAt': FieldValue.serverTimestamp(),
// //     });
// //   }
// // }
//
//
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/capsule.dart';
// import 'cloudinary_upload.dart';
//
// class CapsuleService {
//   final _db = FirebaseFirestore.instance;
//   final CloudinaryUploader uploader;
//
//   CapsuleService({required this.uploader});
//
//   // 1. Creates the main capsule without a cover image
//   Future<String> createCapsule(Capsule capsule) async {
//     final doc = _db.collection('capsules').doc();
//     await doc.set({
//       ...capsule.toJson(),
//       'id': doc.id,
//       'coverImageUrl': '',
//       'createdAt': FieldValue.serverTimestamp(),
//       'updatedAt': FieldValue.serverTimestamp(),
//     });
//     return doc.id;
//   }
//
//   // 2. STREAMS: For fetching data in real-time
//
//   // Used by Home Screen to show the list
//   // Stream<List<Capsule>> streamCapsulesForUser(String uid) {
//   //   return _db
//   //       .collection('capsules')
//   //       .where(Filter.or(
//   //     Filter('ownerId', isEqualTo: uid),
//   //     Filter('collaborators', arrayContains: uid),
//   //   ))
//   //       .orderBy('updatedAt', descending: true)
//   //       .snapshots()
//   //       .map((snap) => snap.docs.map((d) => Capsule.fromJson(d.data())).toList());
//   // }
//
//   // lib/features/capsules/services/capsule_service.dart
//
//   Stream<List<Capsule>> streamCapsulesForUser(String uid) {
//     return _db
//         .collection('capsules')
//     // Try removing the Filter.or temporarily to see if basic fetch works
//         .where('ownerId', isEqualTo: uid)
//         .orderBy('updatedAt', descending: true)
//         .snapshots()
//         .map((snap) => snap.docs.map((d) => Capsule.fromJson(d.data())).toList());
//   }
//
//   // Used by Detail Screen for metadata (Title, Dates)
//   // Fetch the main metadata document
//   Stream<Capsule> streamCapsule(String id) {
//     return _db.collection('capsules').doc(id).snapshots().map((d) => Capsule.fromJson(d.data()!));
//   }
//
// // Fetch the images/videos/notes from the subcollection
//   Stream<List<Map<String, dynamic>>> streamContents(String capsuleId) {
//     return _db
//         .collection('capsules')
//         .doc(capsuleId)
//         .collection('contents')
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snap) => snap.docs.map((d) => d.data() as Map<String, dynamic>).toList());
//   }
//
//   // Used by Detail Screen for subcollection (Photos and Notes)
//   // This fixes the error on line 626 by returning the correct Map type
//   Stream<List<Map<String, dynamic>>> streamContents(String capsuleId) {
//     return _db
//         .collection('capsules')
//         .doc(capsuleId)
//         .collection('contents')
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snap) => snap.docs.map((d) => d.data() as Map<String, dynamic>).toList());
//   }
//
//   // 3. WRITES: For adding new content to existing capsules
//
//   Future<void> addMediaContent(String capsuleId, File file, String uid) async {
//     final String mediaUrl = await uploader.uploadImage(file);
//
//     await _db.collection('capsules').doc(capsuleId).collection('contents').add({
//       'type': 'image',
//       'mediaUrl': mediaUrl,
//       'createdBy': uid,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//
//     await _db.collection('capsules').doc(capsuleId).update({
//       'updatedAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//   Future<void> addTextContent(String capsuleId, String text, String uid) async {
//     await _db.collection('capsules').doc(capsuleId).collection('contents').add({
//       'type': 'text',
//       'text': text,
//       'createdBy': uid,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//
//     await _db.collection('capsules').doc(capsuleId).update({
//       'updatedAt': FieldValue.serverTimestamp(),
//     });
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

  // 1. Create the main capsule document
  Future<String> createCapsule(Capsule capsule) async {
    final doc = _db.collection('capsules').doc();
    await doc.set({
      ...capsule.toJson(),
      'id': doc.id,
      'coverImageUrl': '', // Strictly empty as requested
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return doc.id;
  }

  // 2. STREAMS: Fetching data in real-time

  // Used by Home Screen
  // NOTE: If this returns "Error loading capsules", check the Debug Console for an Index URL
  Stream<List<Capsule>> streamCapsulesForUser(String uid) {
    return _db
        .collection('capsules')
        .where('ownerId', isEqualTo: uid)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Capsule.fromJson(d.data())).toList());
  }

  // Used by Detail Screen for metadata (Title, Dates)
  Stream<Capsule> streamCapsule(String id) {
    return _db.collection('capsules').doc(id).snapshots().map((d) {
      if (!d.exists) throw Exception("Capsule not found");
      return Capsule.fromJson(d.data()!);
    });
  }

  // Used by Detail Screen for the 'contents' subcollection (Photos/Notes)
  // FIXED: Removed duplicate and ensured correct casting for the UI
  Stream<List<Map<String, dynamic>>> streamContents(String capsuleId) {
    return _db
        .collection('capsules')
        .doc(capsuleId)
        .collection('contents')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data() as Map<String, dynamic>).toList());
  }

  // 3. WRITES: Adding content into subcollections

  Future<void> addMediaContent(String capsuleId, File file, String uid) async {
    // Upload to Cloudinary first
    final String mediaUrl = await uploader.uploadImage(file);

    // Save the URL into the 'contents' subcollection [Image of Firestore nested subcollection structure]
    await _db.collection('capsules').doc(capsuleId).collection('contents').add({
      'type': 'image',
      'mediaUrl': mediaUrl,
      'createdBy': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Update parent timestamp to bubble it to the top of the home screen
    await _db.collection('capsules').doc(capsuleId).update({
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> addTextContent(String capsuleId, String text, String uid) async {
    await _db.collection('capsules').doc(capsuleId).collection('contents').add({
      'type': 'text',
      'text': text,
      'createdBy': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _db.collection('capsules').doc(capsuleId).update({
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}