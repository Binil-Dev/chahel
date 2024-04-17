import 'package:cloud_firestore/cloud_firestore.dart';

class SectionModel {
  String? id;
  String? stdId;
  String? subId;
  String? medId;
  String? chapterId;
  Timestamp? isCreated;
  String? sectionName;
  int? sectionNumber;
  String? description;
  String? videoUrl;
  String? image;
  String? pdfUrl;
  //terms and condition
  String? topic;
  int? numberOfquestion;
  int? averageMark;
  int? totalMark;
  int? totalTime;
  SectionModel({
    this.id,
    this.stdId,
    this.subId,
    this.medId,
    this.chapterId,
    this.isCreated,
    this.sectionNumber,
    this.sectionName,
    this.description,
    this.videoUrl,
    this.image,
    this.pdfUrl,
    this.topic,
    this.numberOfquestion,
    this.averageMark,
    this.totalMark,
    this.totalTime,
  });

  SectionModel copyWith({
    String? id,
    String? stdId,
    String? subId,
    String? medId,
    String? chapterId,
    Timestamp? isCreated,
    String? sectionName,
    String? description,
    String? videoUrl,
    String? image,
    String? pdfUrl,
    int? sectionNumber,
    //terms
    String? topic,
    int? numberOfquestion,
    int? averageMark,
    int? totalMark,
    int? totalTime,
  }) {
    return SectionModel(
      sectionNumber: sectionNumber ?? this.sectionNumber,
      id: id ?? this.id,
      stdId: stdId ?? this.stdId,
      subId: subId ?? this.subId,
      medId: medId ?? this.medId,
      chapterId: chapterId ?? this.chapterId,
      isCreated: isCreated ?? this.isCreated,
      sectionName: sectionName ?? this.sectionName,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      image: image ?? this.image,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      //terms
      topic: topic ?? this.topic,
      numberOfquestion: numberOfquestion ?? this.numberOfquestion,
      averageMark: averageMark ?? this.averageMark,
      totalMark: totalMark ?? this.totalMark,
      totalTime: totalTime ?? this.totalTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stdId': stdId,
      'subId': subId,
      'medId': medId,
      'chapterId': chapterId,
      'isCreated': isCreated,
      'sectionName': sectionName,
      'description': description,
      'videoUrl': videoUrl,
      'image': image,
      'pdfUrl': pdfUrl,
      'sectionNumber' : sectionNumber,
      //terms
      'topic': topic,
      'numberOfquestion': numberOfquestion,
      'averageMark': averageMark,
      'totalMark': totalMark,
      'totalTime': totalTime,
    };
  }

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      id: map['id'] != null ? map['id'] as String : null,
      sectionNumber: map['sectionNumber'] != null ? map['sectionNumber'] as int : null,
      stdId: map['stdId'] != null ? map['stdId'] as String : null,
      subId: map['subId'] != null ? map['subId'] as String : null,
      medId: map['medId'] != null ? map['medId'] as String : null,
      chapterId: map['chapterId'] != null ? map['chapterId'] as String : null,
      isCreated:
          map['isCreated'] != null ? map['isCreated'] as Timestamp : null,
      sectionName: map['sectionName']!= null ? map['sectionName']as String  : null,
      description: map['description']!= null ? map['description'] as String  : null,
      videoUrl: map['videoUrl'] != null ? map['videoUrl'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      pdfUrl: map['pdfUrl'] != null ? map['pdfUrl'] as String : null,
      //terms
      topic: map['topic'] != null ? map['topic'] as String : null,
      numberOfquestion: map['numberOfquestion'] != null ? map['numberOfquestion'] as int : null,
      averageMark: map['averageMark'] != null ? map['averageMark'] as int : null,
      totalMark: map['totalMark'] != null ? map['totalMark'] as int : null,
      totalTime: map['totalTime'] != null ? map['totalTime'] as int : null,
    );
  }
}
