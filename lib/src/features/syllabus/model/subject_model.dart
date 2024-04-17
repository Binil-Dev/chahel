

import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  final String? id;
  final String? stdId;
  final String? medId;
  final String? image;
  final Timestamp? isCreated;
  final String subject;
  SubjectModel({
    this.id,
    this.stdId,
    this.medId,
    required this.image,
    this.isCreated,
    required this.subject,
  });

  SubjectModel copyWith({
    String? id,
    String? stdId,
    String? medId,
    String? image,
    Timestamp? isCreated,
    String? subject,
  }) {
    return SubjectModel(
      id: id ?? this.id,
      stdId: stdId ?? this.stdId,
      medId: medId ?? this.medId,
      image: image ?? this.image,
      isCreated: isCreated ?? this.isCreated,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stdId': stdId,
      'medId': medId,
      'image': image,
      'isCreated': isCreated,
      'subject': subject,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['id'] != null ? map['id'] as String : null,
      stdId: map['stdId'] != null ? map['stdId'] as String : null,
      medId: map['medId'] != null ? map['medId'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      isCreated: map['isCreated'] != null ? map['isCreated'] as Timestamp : null,
      subject: map['subject'] as String,
    );
  }


}
