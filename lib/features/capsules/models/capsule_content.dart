// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class CapsuleContent {
//   final String id;
//   final String type; // "text" | "image" | "video"
//   final String? storagePath;
//   final String? text;
//   final String createdBy;
//   final DateTime? createdAt;
//
//   CapsuleContent({
//     required this.id,
//     required this.type,
//     required this.createdBy,
//     this.storagePath,
//     this.text,
//     this.createdAt,
//   });
//
//   factory CapsuleContent.fromJson(Map<String, dynamic> json) => CapsuleContent(
//     id: json['id'] ?? '',
//     type: json['type'] ?? 'text',
//     storagePath: json['storagePath'],
//     text: json['text'],
//     createdBy: json['createdBy'] ?? '',
//     createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'type': type,
//     'storagePath': storagePath,
//     'text': text,
//     'createdBy': createdBy,
//     'createdAt': createdAt,
//   };
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class CapsuleContent {
  final String id;
  final String type; // "text" | "image" | "video"
  final String? storagePath;
  final String? text;
  final String createdBy;
  final DateTime? createdAt;

  CapsuleContent({
    required this.id,
    required this.type,
    required this.createdBy,
    this.storagePath,
    this.text,
    this.createdAt,
  });

  factory CapsuleContent.fromJson(Map<String, dynamic> json) => CapsuleContent(
    id: json['id'] ?? '',
    type: json['type'] ?? 'text',
    storagePath: json['storagePath'],
    text: json['text'],
    createdBy: json['createdBy'] ?? '',
    createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'storagePath': storagePath,
    'text': text,
    'createdBy': createdBy,
    'createdAt': createdAt,
  };
}