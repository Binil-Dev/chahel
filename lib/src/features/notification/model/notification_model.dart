

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? id;
  String? image;
  String? title;
  String? content;
  Timestamp? timestamp;
  NotificationModel({
    this.id,
    this.image,
    this.title,
    this.content,
    this.timestamp,
  });

  NotificationModel copyWith({
    String? id,
    String? image,
    String? title,
    String? content,
    Timestamp? timestamp,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      timestamp: map['timestamp'] != null ? map['timestamp'] as Timestamp : null,
    );
  }



}
