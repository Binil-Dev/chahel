
// class TermsAndConditionModel {
//   String? id;
//   String? topic;
//   int? numberOfquestion;
//   int? averageMark;
//   int? totalMark;
//   int? totalTime;
//   TermsAndConditionModel({
//     this.id,
//     this.topic,
//     this.numberOfquestion,
//     this.averageMark,
//     this.totalMark,
//     this.totalTime,

//   });

//   TermsAndConditionModel copyWith({
//     String? id,
//     String? topic,
//     int? numberOfquestion,
//     int? averageMark,
//     int? totalMark,
//     int? totalTime,
//   }) {
//     return TermsAndConditionModel(
//       id: id ?? this.id,
//       topic: topic ?? this.topic,
//       numberOfquestion: numberOfquestion ?? this.numberOfquestion,
//       averageMark: averageMark ?? this.averageMark,
//       totalMark: totalMark ?? this.totalMark,
//       totalTime: totalTime ?? this.totalTime,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'topic': topic,
//       'numberOfquestion': numberOfquestion,
//       'averageMark': averageMark,
//       'totalMark': totalMark,
//       'totalTime': totalTime,
//     };
//   }

//   factory TermsAndConditionModel.fromMap(Map<String, dynamic> map) {
//     return TermsAndConditionModel(
//       id: map['id'] != null ? map['id'] as String : null,
//       topic: map['topic'] != null ? map['topic'] as String : null,
//       numberOfquestion: map['numberOfquestion'] != null ? map['numberOfquestion'] as int : null,
//       averageMark: map['averageMark'] != null ? map['averageMark'] as int : null,
//       totalMark: map['totalMark'] != null ? map['totalMark'] as int : null,
//       totalTime: map['totalTime'] != null ? map['totalTime'] as int : null,

//     );
//   }

// }