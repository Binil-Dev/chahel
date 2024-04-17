class ExamModel {
  String id;
  String question;
  List<String> options;
  int answer;
  ExamModel({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
  });

  ExamModel copyWith({
    String? question,
    List<String>? options,
    int? answer,
  }) {
    return ExamModel(
      id: id,
      question: question ?? this.question,
      options: options ?? this.options,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'options': options,
      'answer': answer,
      'id': id,
    };
  }

  factory ExamModel.fromMap(Map<String, dynamic> map) {
    return ExamModel(
      question: map['question'] as String,
      options: (map['examData'] as List<dynamic>).cast<String>(),
      answer: map['answer'] as int,
      id: map['id'],
    );
  }
}

class ListExamModel {
  String sectionId;
  String? stdId;
  String? subId;
  String? medId;
  String? chapterId;
  List<ExamModel> examData;
  ListExamModel({
    this.stdId,
    this.subId,
    this.medId,
    this.chapterId,
    required this.sectionId,
    required this.examData,

  });

  ListExamModel copyWith({
   String? stdId,
    String? subId,
    String? medId,
    String? chapterId,
    String? sectionId,
    List<ExamModel>? examData,
  }) {
    return ListExamModel(
      stdId: stdId ?? this.stdId,
      subId: subId ?? this.subId,
      medId: medId ?? this.medId,
      chapterId: chapterId ?? this.chapterId,
      sectionId: sectionId ?? this.sectionId,
      examData: examData ?? this.examData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stdId': stdId,
      'subId': subId,
      'medId': medId,
      'chapterId': chapterId,
      'sectionId': sectionId,
      'examData': ListExamModel.listToMapofMap(examData),
    };
  }

  factory ListExamModel.fromMap(Map<String, dynamic> map) {
    return ListExamModel(
      stdId: map['stdId'] != null ? map['stdId'] as String : null,
      subId: map['subId'] != null ? map['subId'] as String : null,
      medId: map['medId'] != null ? map['medId'] as String : null,
      chapterId: map['chapterId'] != null ? map['chapterId'] as String : null,
      sectionId: map['sectionId'] as String,
      examData: mapToListofExamModel(extractData(map['examData'])),
    );
  }

  //list to map of map
  static Map<String, Map<String, dynamic>> listToMapofMap( List<ExamModel> examList) {
    Map<String, Map<String, dynamic>> resultMap = {};

    for (ExamModel exam in examList) {
      resultMap[exam.id] = exam.toMap();
    }

    return resultMap;
  }

//MAP OF MAP CONVERT TO LIST<EXAMMODEL>
  static List<ExamModel> mapToListofExamModel(
      Map<String, Map<String, dynamic>> map) {
    List<ExamModel> resultList = [];

    map.entries.forEach((entry) {
      Map<String, dynamic> examData = entry.value;
      ExamModel examModel = ExamModel(
        id: examData['id'],
        question: examData['question'],
        options: List<String>.from(examData['options']),
        answer: examData['answer'],
      );

      resultList.add(examModel);
    });
    return resultList;
  }

//FIRESTORE DATA CONVERT TO TYPE MAP<STRING,MAP<STRING,DYNAMIC>>
  static Map<String, Map<String, dynamic>> extractData(
      Map<String, dynamic> data) {
    Map<String, Map<String, dynamic>> resultMap = {};

    data.forEach((key, value) {
      resultMap[key] = Map<String, dynamic>.from(value);
    });

    return resultMap;
  }
}