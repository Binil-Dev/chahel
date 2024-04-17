
import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterModel {
  String? id;
  String? stdId;
  String? subId;
  String? medId;
  Timestamp? isCreated;
  String chapter;
  String about;
  int? sectionNumber;
  ChapterModel({
    this.id,
    this.stdId,
    this.subId,
    this.medId,
    this.isCreated,
    this.sectionNumber,
    required this.chapter,
    required this.about,
  });

  ChapterModel copyWith({
    String? id,
    String? stdId,
    String? subId,
    String? medId,
    Timestamp? isCreated,
    String? chapter,
    String? about,
    int? sectionNumber,
  }) {
    return ChapterModel(

      id: id ?? this.id,
      stdId: stdId ?? this.stdId,
      subId: subId ?? this.subId,
      medId: medId ?? this.medId,
      isCreated: isCreated ?? this.isCreated,
      chapter: chapter ?? this.chapter,
      about: about ?? this.about,
      sectionNumber: sectionNumber ?? this.sectionNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stdId': stdId,
      'subId': subId,
      'medId': medId,
      'isCreated': isCreated,
      'chapter': chapter,
      'about': about,
      'sectionNumber' : sectionNumber,
    };
  }

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      id: map['id'] != null ? map['id'] as String : null,
      stdId: map['stdId'] != null ? map['stdId'] as String : null,
      subId: map['subId'] != null ? map['subId'] as String : null,
      medId: map['medId'] != null ? map['medId'] as String : null,
      isCreated: map['isCreated'] != null ? map['isCreated'] as Timestamp : null,
      sectionNumber: map['sectionNumber'] != null ? map['sectionNumber'] as int : null,
      chapter: map['chapter'] as String,
      about: map['about'] as String,
    );
  }

}