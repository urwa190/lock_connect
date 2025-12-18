// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class CollabRequest {
//   final String id;
//   final String capsuleId;
//   final String fromUid;
//   final String toUid;
//   final String status; // pending | accepted | rejected
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   CollabRequest({
//     required this.id,
//     required this.capsuleId,
//     required this.fromUid,
//     required this.toUid,
//     required this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory CollabRequest.fromJson(Map<String, dynamic> json) => CollabRequest(
//     id: json['id'] ?? '',
//     capsuleId: json['capsuleId'] ?? '',
//     fromUid: json['fromUid'] ?? '',
//     toUid: json['toUid'] ?? '',
//     status: json['status'] ?? 'pending',
//     createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
//     updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'capsuleId': capsuleId,
//     'fromUid': fromUid,
//     'toUid': toUid,
//     'status': status,
//     'createdAt': createdAt,
//     'updatedAt': updatedAt,
//   };
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class CollabRequest {
  final String id;
  final String capsuleId;
  final String fromUid;
  final String toUid;
  final String status; // pending | accepted | rejected
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CollabRequest({
    required this.id,
    required this.capsuleId,
    required this.fromUid,
    required this.toUid,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CollabRequest.fromJson(Map<String, dynamic> json) => CollabRequest(
    id: json['id'] ?? '',
    capsuleId: json['capsuleId'] ?? '',
    fromUid: json['fromUid'] ?? '',
    toUid: json['toUid'] ?? '',
    status: json['status'] ?? 'pending',
    createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'capsuleId': capsuleId,
    'fromUid': fromUid,
    'toUid': toUid,
    'status': status,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}