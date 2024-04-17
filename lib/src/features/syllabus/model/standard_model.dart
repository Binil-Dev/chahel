import 'package:cloud_firestore/cloud_firestore.dart';

class StandardsModel {
  final String? id;
  final String image;
  final String standard;
  final Timestamp? isCreated;
  StandardsModel({
    this.id,
    required this.image,
    required this.standard,
    this.isCreated,
  });

  StandardsModel copyWith({
    String? id,
    String? image,
    String? standard,
    Timestamp? isCreated,
  }) {
    return StandardsModel(
      id: id ?? this.id,
      image: image ?? this.image,
      standard: standard ?? this.standard,
      isCreated: isCreated ?? this.isCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'standard': standard,
      'isCreated': isCreated,
    };
  }

  factory StandardsModel.fromMap(Map<String, dynamic> map) {
    return StandardsModel(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] as String,
      standard: map['standard'] as String,
      isCreated: map['isCreated'] != null ? map['isCreated'] as Timestamp : null,
    );
  }

}