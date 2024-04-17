import 'package:cloud_firestore/cloud_firestore.dart';

class MediumModel {
  final String? id;
  final String? stdId;
  final Timestamp? timestamp;
  final String image;
  final String medium;

  MediumModel({
    this.id,
     this.stdId,
    this.timestamp,
    required this.image,
    required this.medium,
  });

  MediumModel copyWith({
    String? id,
    String? stdId,
    Timestamp? isCreated,
    String? image,
    String? medium,
  }) {
    return MediumModel(
      id: id ?? this.id,
      stdId: stdId ?? this.stdId,
      timestamp: timestamp ?? this.timestamp,
      image: image ?? this.image,
      medium: medium ?? this.medium,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stdId': stdId,
      'timestamp': timestamp,
      'image': image,
      'medium': medium,
    };
  }

  factory MediumModel.fromMap(Map<String, dynamic> map) {
    return MediumModel(
      id: map['id'] != null ? map['id'] as String : null,
      stdId: map['stdId'] != null ? map['stdId'] as String : null,
      timestamp: map['timestamp'] != null ? map['timestamp'] as Timestamp : null,
      image: map['image'] as String,
      medium: map['medium'] as String,
    );
  }

}
