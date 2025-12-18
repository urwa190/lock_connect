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
  final DateTime? updatedAt;

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
    this.updatedAt,
  });

  factory Capsule.fromJson(Map<String, dynamic> json) {
    // Helper to safely convert Firestore Timestamps to DateTime
    DateTime? dateTimeFromTimestamp(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      } else if (value is String) {
        return DateTime.tryParse(value);
      }
      return null;
    }

    return Capsule(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Untitled Capsule',
      description: json['description'] as String? ?? '',
      ownerId: json['ownerId'] as String? ?? '',
      isPrivate: json['isPrivate'] == true,
      // Default to true so users can't see content if database field is missing
      isLocked: json['isLocked'] ?? true,
      unlockAt: dateTimeFromTimestamp(json['unlockAt']),
      coverImageUrl: json['coverImageUrl'] as String? ?? '',
      collaborators: json['collaborators'] != null
          ? List<String>.from(json['collaborators'])
          : [],
      createdAt: dateTimeFromTimestamp(json['createdAt']),
      updatedAt: dateTimeFromTimestamp(json['updatedAt']),
    );
  }

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
    // Use FieldValue.serverTimestamp() when creating new records
    // to ensure the clock is synced with the server
    'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : FieldValue.serverTimestamp(),
  };


}

