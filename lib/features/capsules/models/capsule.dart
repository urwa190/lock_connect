// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // //
// // // class Capsule {
// // //   final String id;
// // //   final String title;
// // //   final String description;
// // //   final String ownerId;
// // //   final bool isPrivate;
// // //   final String coverImageUrl;
// // //   final List<String> collaborators;
// // //   final DateTime? createdAt;
// // //   final DateTime? updatedAt;
// // //
// // //   Capsule({
// // //     required this.id,
// // //     required this.title,
// // //     required this.description,
// // //     required this.ownerId,
// // //     required this.isPrivate,
// // //     required this.coverImageUrl,
// // //     required this.collaborators,
// // //     this.createdAt,
// // //     this.updatedAt,
// // //   });
// // //
// // //   factory Capsule.fromJson(Map<String, dynamic> json) => Capsule(
// // //     id: json['id'] ?? '',
// // //     title: json['title'] ?? '',
// // //     description: json['description'] ?? '',
// // //     ownerId: json['ownerId'] ?? '',
// // //     isPrivate: json['isPrivate'] ?? false,
// // //     coverImageUrl: json['coverImageUrl'] ?? '',
// // //     collaborators: List<String>.from(json['collaborators'] ?? []),
// // //     createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
// // //     updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
// // //   );
// // //
// // //   Map<String, dynamic> toJson() => {
// // //     'id': id,
// // //     'title': title,
// // //     'description': description,
// // //     'ownerId': ownerId,
// // //     'isPrivate': isPrivate,
// // //     'coverImageUrl': coverImageUrl,
// // //     'collaborators': collaborators,
// // //     'createdAt': createdAt,
// // //     'updatedAt': updatedAt,
// // //   };
// // // }
// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class Capsule {
// //   final String id;
// //   final String title;
// //   final String description;
// //   final String ownerId;
// //   final bool isPrivate;
// //   final String coverImageUrl;
// //   final List<String> collaborators;
// //   final DateTime? createdAt;
// //   final DateTime? updatedAt;
// //
// //   Capsule({
// //     required this.id,
// //     required this.title,
// //     required this.description,
// //     required this.ownerId,
// //     required this.isPrivate,
// //     required this.coverImageUrl,
// //     required this.collaborators,
// //     this.createdAt,
// //     this.updatedAt, required bool isLocked, required DateTime unlockAt,
// //   });
// //
// //   factory Capsule.fromJson(Map<String, dynamic> json) => Capsule(
// //     id: json['id'] ?? '',
// //     title: json['title'] ?? '',
// //     description: json['description'] ?? '',
// //     ownerId: json['ownerId'] ?? '',
// //     isPrivate: json['isPrivate'] ?? false,
// //     coverImageUrl: json['coverImageUrl'] ?? '',
// //     collaborators: List<String>.from(json['collaborators'] ?? []),
// //     createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
// //     updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     'id': id,
// //     'title': title,
// //     'description': description,
// //     'ownerId': ownerId,
// //     'isPrivate': isPrivate,
// //     'coverImageUrl': coverImageUrl,
// //     'collaborators': collaborators,
// //     'createdAt': createdAt,
// //     'updatedAt': updatedAt,
// //   };
// // }
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Capsule {
//   final String id;
//   final String title;
//   final String description;
//   final String ownerId;
//   final bool isPrivate;
//   final bool isLocked;
//   final DateTime? unlockAt;
//   final String coverImageUrl;
//   final List<String> collaborators;
//   final DateTime? createdAt;
//
//   Capsule({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.ownerId,
//     required this.isPrivate,
//     required this.isLocked,
//     required this.unlockAt,
//     required this.coverImageUrl,
//     required this.collaborators,
//     this.createdAt,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'title': title,
//     'description': description,
//     'ownerId': ownerId,
//     'isPrivate': isPrivate,
//     'isLocked': isLocked,
//     'unlockAt': unlockAt != null ? Timestamp.fromDate(unlockAt!) : null,
//     'coverImageUrl': coverImageUrl,
//     'collaborators': collaborators,
//     'createdAt': createdAt ?? FieldValue.serverTimestamp(),
//   };
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class Capsule {
  final String id;
  final String title;
  final String description;
  final String ownerId;
  final bool isPrivate;
  final bool isLocked;
  final DateTime? unlockAt;
  final String coverImageUrl;
  final List<String> collaborators;
  final DateTime? createdAt;
  final DateTime? updatedAt; // ADD THIS

  Capsule({
    required this.id,
    required this.title,
    required this.description,
    required this.ownerId,
    required this.isPrivate,
    required this.isLocked,
    required this.unlockAt,
    required this.coverImageUrl,
    required this.collaborators,
    this.createdAt,
    this.updatedAt, // ADD THIS
  });

  factory Capsule.fromJson(Map<String, dynamic> json) => Capsule(
    id: json['id'] ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    ownerId: json['ownerId'] ?? '',
    isPrivate: json['isPrivate'] ?? false,
    isLocked: json['isLocked'] ?? true, // Default to true for security
    unlockAt: (json['unlockAt'] as Timestamp?)?.toDate(),
    coverImageUrl: json['coverImageUrl'] ?? '',
    collaborators: List<String>.from(json['collaborators'] ?? []),
    createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'ownerId': ownerId,
    'isPrivate': isPrivate,
    'isLocked': isLocked,
    'unlockAt': unlockAt != null ? Timestamp.fromDate(unlockAt!) : null,
    'coverImageUrl': coverImageUrl,
    'collaborators': collaborators,
    'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    'updatedAt': updatedAt ?? FieldValue.serverTimestamp(), // MAP THIS
  };
}