import 'dart:developer';
import 'package:chahel_web_1/src/features/syllabus/model/chapter_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/exam_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/medium_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/section_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/standard_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/subject_model.dart';
import 'package:chahel_web_1/src/repository/common_repository.dart';
import 'package:chahel_web_1/src/repository/syllabus_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SyllabusController extends ChangeNotifier {
  final SyllabusRepository _syllabusRepo = SyllabusRepository.instance;
  final Repository _commonRepo = Repository.instance;
//  IMAGE SECTION

//get image
  Uint8List? imageBytes; //not as file it is in unit8list
  String? imageUrl;

  Future<void> getImage({
    required void Function(String) onSucess,
    required void Function(String) onFailure,

    ///change imagefile to imagebytes
  }) async {
    imageUrl = null;
    final image = await _commonRepo.getGalleryImage(
        onSucess: onSucess, onFailure: onFailure);
    if (image == null) return;
    imageBytes = image;

    notifyListeners();
  }

//save image
  Future<void> saveMainImage({
    required Uint8List? imageBytes,
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    if (imageBytes == null) {
      onFailure;
      return;
    }
    String? url = await _commonRepo.saveImage(
        imageBytes: imageBytes, onSucess: onSucess, onFailure: onFailure);
    if (url != null) {
      imageUrl = url;
    }
    notifyListeners();
  }

  //delete Image from storage
  Future<void> clearStorageImage({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    if (imageUrl != null) {
      await _commonRepo.deleteUrl(
          imageUrl: imageUrl!, onSucess: onSucess, onFailure: onFailure);
      imageUrl = null;
    }

    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////
  /// SYLLABUS
  /// ////////////////////////
  bool fetchloading = true;
//  1.Standards add section
  StandardsModel? standards;
  List<StandardsModel> standardsList = [];
  final TextEditingController standardTextController = TextEditingController();
  Timestamp? timestamp; ///////////// time stamp for every one
  Future<void> addNewStandards({
    required VoidCallback onSucess,
    required void Function(String) onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    standards = StandardsModel(
        image: imageUrl!,
        standard: standardTextController.text,
        isCreated: Timestamp.now());
    await _syllabusRepo.createNewStandards(
        standards: standards!,
        onSucess: (value) {
          standardsList.insert(standardsList.length, value);
          onSucess.call();
          fetchloading = true;
          notifyListeners();
          log('standard firestore');
        },
        onFailure: onFailure);
  }

  //clear standard
  void clearStandardFields() {
    standards = null;
    imageBytes = null;
    timestamp = null;
    standardTextController.clear();
    if (imageUrl != null) {
      imageUrl = null;
    }

    notifyListeners();
  }

//check if we want to delete the current standard because that there is medium inside

////delete standard

  Future<void> deleteStandards({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
    required void Function(String) onboolToast,
  }) async {
    final boolMedium =
        await _syllabusRepo.getMediumBool(onFailure: onboolToast, stdId: id!);
    if (boolMedium) {
      await _syllabusRepo.deleteStandards(
          id: id,
          onSucess: () {
            standardsList.removeAt(index);
            onSucess.call();
            notifyListeners();
          },
          onFailure: onFailure);
    } else {
      onboolToast.call("Can't able to delete, there is medium document inside");
    }
  }

// update standard
  Future<void> editStandards({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    standards = StandardsModel(
        image: imageUrl!,
        standard: standardTextController.text,
        isCreated: timestamp);
    await _syllabusRepo.updateStandards(
      model: standards!,
      id: id,
      //value is standard
      onSucess: (value) {
        standardsList.removeAt(index);
        standardsList.insert(index, value);
        onSucess.call();
      },
      onFailure: onFailure,
    );

    fetchloading = true;
    notifyListeners();
  }

//---edit function standard
  void setEditDataStandards(StandardsModel standartEditModel) {
    standardTextController.text = standartEditModel.standard;
    imageUrl = standartEditModel.image;
    timestamp = standartEditModel.isCreated;
  }

  //get the standard
  Future<void> getStandardsList(
      {required void Function(String) onFailure}) async {

    standardsList.clear();
    fetchloading = false;
    notifyListeners();  
    await _syllabusRepo.getStandards(onFailure: onFailure).then((value) {
      standardsList.addAll(value ?? []);
      log('get standards');
        fetchloading = true;
      notifyListeners();
    });
  }

/////////////////////////////////////////////////////////////////////////
// 2. Medium section-----------------------------------

  StandardsModel? selectedStandardId;

  //select subject to pass the id in medium to subject

  void selectStandardIdFn(StandardsModel standard) {
    selectedStandardId = standard;
    notifyListeners();
  }

  MediumModel? mediums;
  List<MediumModel> mediumsList = [];
  final TextEditingController mediumController = TextEditingController();

  Future<void> addNewMedium({
    required VoidCallback onSucess,
    required void Function(String) onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    mediums = MediumModel(
        stdId: selectedStandardId?.id,
        image: imageUrl!,
        medium: mediumController.text,
        timestamp: Timestamp.now());

    await _syllabusRepo.createNewMedium(
        medium: mediums!,
        onSucess: (value) {
          mediumsList.insert(mediumsList.length, value);
          onSucess.call();
          log('medium firestore');
        },
        onFailure: onFailure);
    fetchloading = true;
    notifyListeners();
  }

//fields to be add MEDIUM MODEL

  //clear medium
  void clearMediumFields() {
    mediums = null;
    imageBytes = null;
    timestamp = null;
    mediumController.clear();
    if (imageUrl != null) {
      imageUrl = null;
    }

    notifyListeners();
  }

//check if we want to delete the current medium because that there is subject inside
//delete medium
  Future<void> mediumDelete({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
    required void Function(String) onboolToast,
  }) async {
    final boolSubject =
        await _syllabusRepo.getSubjectBool(onFailure: onboolToast, medId: id!);
    if (boolSubject) {
      await _syllabusRepo.deleteMedium(
          id: id,
          onSucess: () {
            mediumsList.removeAt(index);
            onSucess.call();
          },
          onFailure: onFailure);
    } else {
      onboolToast
          .call("Can't able to delete, there is subject document inside");
    }
    notifyListeners();
  }

// update medium
  Future<void> editMedium({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    mediums = MediumModel(
      stdId: selectedStandardId?.id,
      image: imageUrl!,
      medium: mediumController.text,
      timestamp: timestamp,
    );
    await _syllabusRepo.updateMedium(
      model: mediums!,
      id: id,
      //value is medium
      onSucess: (value) {
        mediumsList.removeAt(index);
        mediumsList.insert(index, value);
        onSucess.call();
      },
      onFailure: onFailure,
    );
    fetchloading = true;
    notifyListeners();
  }

//- edit medium function
  void setEditDataMedium(MediumModel mediumEditModel) {
    mediumController.text = mediumEditModel.medium;
    imageUrl = mediumEditModel.image;
    timestamp = mediumEditModel.timestamp;
  }

  //get the medium
  Future<void> getMediumList(
      {required void Function(String) onFailure, required String stdId}) async {
    mediumsList.clear();
     fetchloading = false;
    notifyListeners();
    await _syllabusRepo
        .getMedium(stdId: stdId, onFailure: onFailure)
        .then((value) {
      mediumsList.addAll((value ?? []));
      log('get standards');
        fetchloading = true;
      notifyListeners();
    });
  }
///////////////////////////////////////////////////////////

//   3.subject------------------------------

  MediumModel? selectedMediumId;

  //select subject to pass the id in medium to subject

  void selectMediumIdFn(MediumModel medium) {
    selectedMediumId = medium;
    notifyListeners();
  }

  SubjectModel? subjects;
  List<SubjectModel?> subjectList = [];
  final TextEditingController subjectController = TextEditingController();
//create a subject
  Future<void> addNewSubject({
    required VoidCallback onSucess,
    required void Function(String) onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    subjects = SubjectModel(
        image: imageUrl!,
        subject: subjectController.text,
        stdId: selectedMediumId?.stdId,
        medId: selectedMediumId?.id,
        isCreated: Timestamp.now());
    await _syllabusRepo.createNewSubject(
        subject: subjects!,
        onSucess: (value) {
          subjectList.insert(subjectList.length, value);
          onSucess.call();

          log('subject firestore');
        },
        onFailure: onFailure);

    fetchloading = true;
    notifyListeners();
  }

  //clear subject// made the subject field also null to update in the ui f
  void clearSubjectFields() {
    imageBytes = null;
    subjectController.clear();
    timestamp = null;
    subjects = null;
    if (imageUrl != null) {
      imageUrl = null;
    }

    notifyListeners();
  }

//check if we want to delete the current subject because that there is chapter inside
//delete subject
  Future<void> subjectDelete({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
    required void Function(String) onboolToast,
  }) async {
    final boolChapter =
        await _syllabusRepo.getChapterBool(onFailure: onboolToast, subId: id!);
    if (boolChapter) {
      await _syllabusRepo.deleteSubject(
          id: id,
          onSucess: () {
            subjectList.removeAt(index);
            notifyListeners();
            onSucess.call();
          },
          onFailure: onFailure);
    } else {
      onboolToast
          .call("Can't able to delete, there is chapter document inside");
    }
  }

//// update subject
  Future<void> editSubject({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    subjects = SubjectModel(
        isCreated: timestamp,
        image: imageUrl!,
        subject: subjectController.text,
        stdId: selectedMediumId?.stdId,
        medId: selectedMediumId?.id);
    await _syllabusRepo.updateSubject(
      model: subjects!,
      id: id,
      onSucess: (value) {
        subjectList.removeAt(index);
        subjectList.insert(index, value);
        onSucess.call();
      },
      onFailure: onFailure,
    );
    fetchloading = true;
    notifyListeners();
  }

//- edit subject function
  void setEditDataSubject(SubjectModel subjectEditModel) {
    subjectController.text = subjectEditModel.subject;
    imageUrl = subjectEditModel.image;
    timestamp = subjectEditModel.isCreated;
  }

  //get the subject
  Future<void> getSubjectList(
      {required void Function(String) onFailure, required String medId}) async {
    subjectList.clear();
        fetchloading = false;
    notifyListeners();
    await _syllabusRepo
        .getSubject(medId: medId, onFailure: onFailure)
        .then((value) {
      subjectList.addAll((value ?? []));
      log('get subject');
       fetchloading = true;
      notifyListeners();
    });
  }

  ///////////////////////////////////////////////////////////

//   4.Chapter-----------------------------

  SubjectModel? selectedSubjectId;

  //select subject to pass the id in subject to chapter

  void selectSubjectIdFn(SubjectModel subject) {
    selectedSubjectId = subject;
    notifyListeners();
  }

  ChapterModel? chapters;
  List<ChapterModel> chaptersList = [];
  final TextEditingController chapterTitleTextController =
      TextEditingController();
  final TextEditingController chapterAboutTextController =
      TextEditingController();
  final TextEditingController chapterNumberTextController =
      TextEditingController();
//create a Chapter
  Future<void> addNewChapter({
    required VoidCallback onSucess,
    required void Function(String) onFailure,
  }) async {
    log('chapter firestore');
    fetchloading = false;
    notifyListeners();
    chapters = ChapterModel(
        sectionNumber: int.parse(chapterNumberTextController.text),
        stdId: selectedSubjectId?.stdId,
        subId: selectedSubjectId?.id,
        medId: selectedSubjectId?.medId,
        chapter: chapterTitleTextController.text,
        about: chapterAboutTextController.text,
        isCreated: Timestamp.now());
    await _syllabusRepo.createNewChapter(
        chapter: chapters!,
        onSucess: (value) {
          chaptersList.insert(chaptersList.length, value);
          onSucess.call();
        },
        onFailure: onFailure);
    fetchloading = true;
    notifyListeners();
  }

  //clear subject
  void clearChapterFields() {
    chapters = null;
    chapterTitleTextController.clear();
    chapterAboutTextController.clear();
    chapterNumberTextController.clear();
    timestamp = null;
    notifyListeners();
  }

//delete chapter
  Future<void> chapterDelete({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
    required void Function(String) onboolToast,
  }) async {
    final boolSection = await _syllabusRepo.getSectionBool(
        onFailure: onboolToast, chapterId: id!);
    if (boolSection) {
      await _syllabusRepo.deleteChapter(
          id: id,
          onSucess: () {
            chaptersList.removeAt(index);
            onSucess.call();
          },
          onFailure: onFailure);
    } else {
      onboolToast
          .call("Can't able to delete, there is section document inside");
    }
    notifyListeners();
  }

// update Chapter
  Future<void> chapterEdit({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    chapters = ChapterModel(
        sectionNumber: int.parse(chapterNumberTextController.text),
        stdId: selectedSubjectId?.stdId,
        subId: selectedSubjectId?.id,
        medId: selectedSubjectId?.medId,
        chapter: chapterTitleTextController.text,
        about: chapterAboutTextController.text,
        isCreated: timestamp);

    await _syllabusRepo.updateChapter(
      model: chapters!,
      id: id,
      onSucess: (value) {
        chaptersList.removeAt(index);
        chaptersList.insert(index, value);
        onSucess.call();
      },
      onFailure: onFailure,
    );
    fetchloading = true;
    notifyListeners();
  }

//- edit chapter function
  void setEditDataChapter(ChapterModel chapterEditModel) {
    chapterNumberTextController.text =
        chapterEditModel.sectionNumber.toString();
    chapterTitleTextController.text = chapterEditModel.chapter;
    chapterAboutTextController.text = chapterEditModel.about;
    timestamp = chapterEditModel.isCreated;
  }

  //get the chapter
  Future<void> getChapterList(
      {required void Function(String) onFailure, required String subId}) async {
    chaptersList.clear();
        fetchloading = false;
    notifyListeners();
    await _syllabusRepo
        .getChapter(onFailure: onFailure, subId: subId)
        .then((value) {
      chaptersList.addAll((value ?? []));
      log('get chapter');
       fetchloading = true;
      notifyListeners();
    });
  }

  ///////////////////////////////////////////////////////////

//   4.Section -----------------------------------------------------------
// to get chapter id to get the section
  ChapterModel? selectedChaptersId;

  void selectedChapterIdFn(ChapterModel chapterId) {
    selectedChaptersId = chapterId;
    notifyListeners();
  }

  Uint8List? pdfFile;
  String? pdfUrl;
  SectionModel? sections;
  List<SectionModel> sectionlist = [];
  final TextEditingController sectionTitleTextController =
      TextEditingController();
  final TextEditingController sectionAboutTextController =
      TextEditingController();
  final TextEditingController sectionYoutubeURLTextController =
      TextEditingController();
  final TextEditingController sectionNumberTextController =
      TextEditingController();
//create a section
  Future<void> addNewSection({
    required VoidCallback onSucess,
    required void Function(String) onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    sections = SectionModel(
        sectionNumber: int.parse(sectionNumberTextController.text),
        isCreated: Timestamp.now(),
        stdId: selectedChaptersId?.stdId,
        subId: selectedChaptersId?.subId,
        medId: selectedChaptersId?.medId,
        chapterId: selectedChaptersId?.id,
        sectionName: sectionTitleTextController.text,
        description: sectionAboutTextController.text,
        videoUrl: sectionYoutubeURLTextController.text,
        pdfUrl: pdfUrl,
        image: imageUrl!);
    await _syllabusRepo.createNewSection(
        section: sections!,
        onSucess: (value) {
          sectionlist.insert(sectionlist.length, value);
          onSucess.call();

          log('section firestore');
        },
        onFailure: onFailure);
    fetchloading = true;
    notifyListeners();
  }

  //clear section
  void clearSectionFields() {
    sections = null;
    timestamp = null;
    sectionTitleTextController.clear();
    sectionAboutTextController.clear();
    sectionYoutubeURLTextController.clear();
    sectionNumberTextController.clear();
    imageBytes = null;
    pdfFile = null;
    if (imageUrl != null || pdfUrl != null) {
      imageUrl = null;
      pdfUrl = null;
    }
    notifyListeners();
  }

//delete section
  Future<void> sectionDelete({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
    required void Function(String) onboolToast,
    required String pdfUrl,
  }) async {
    // to check if there is document inside the section in exam////////// this is done on every delete
    final boolExam =
        await _syllabusRepo.getExamBool(onFailure: onboolToast, sectionId: id!);
    if (boolExam == false) {
      cancelPdf(
        onFailure: () {},
        pdfUrl: pdfUrl,
        onSucess: () {},
      );
      await _syllabusRepo.deleteSection(
          sectionId: id, onSucess: onSucess, onFailure: onFailure);
      notifyListeners();
    } else {
      onboolToast.call("Can't able to delete, there is exam document inside");
    }
  }

//- edit section function
  void setEditDataSection(SectionModel sectionEditModel) {
    sectionTitleTextController.text = sectionEditModel.sectionName ?? 'section';
    sectionAboutTextController.text =
        sectionEditModel.description ?? 'description';
    sectionYoutubeURLTextController.text = sectionEditModel.videoUrl ?? '';
    sectionNumberTextController.text =
        sectionEditModel.sectionNumber.toString();
    pdfUrl = sectionEditModel.pdfUrl;
    imageUrl = sectionEditModel.image;
    timestamp = sectionEditModel.isCreated;
    notifyListeners();
  }

// update section
  Future<void> sectionEdit({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    sections = SectionModel(
      sectionNumber: int.parse(sectionNumberTextController.text),
      stdId: selectedChaptersId?.stdId,
      subId: selectedChaptersId?.subId,
      medId: selectedChaptersId?.medId,
      chapterId: selectedChaptersId?.id,
      sectionName: sectionTitleTextController.text,
      description: sectionAboutTextController.text,
      videoUrl: sectionYoutubeURLTextController.text,
      pdfUrl: pdfUrl,
      image: imageUrl!,
      isCreated: timestamp,
    );
    await _syllabusRepo.updateSection(
      model: sections!,
      id: id,
      onSucess: (value) {
        sectionlist.removeAt(index);
        sectionlist.insert(index, value);
        onSucess.call();
      },
      onFailure: onFailure,
    );
    fetchloading = true;
    notifyListeners();
  }

  //get the section
  Future<void> getSectionList(
      {required void Function(String) onFailure,
      required String chapterId}) async {
    sectionlist.clear();
        fetchloading = false;
    notifyListeners(); 
    await _syllabusRepo
        .getSection(onFailure: onFailure, chapterId: chapterId)
        .then((value) {
      sectionlist.addAll((value ?? []));
      log('get section');
        fetchloading = true;
      notifyListeners();
    });
  }

//////////////////// PDF SECTION---------------
  ///get pf file
  Future<void> getPdfFile({
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    Uint8List? file = await _syllabusRepo.getPdfFile(
        onSucess: onSucess, onFailure: onFailure);
    if (file != null) {
      pdfFile = file;
      onSucess.call();
    }
    notifyListeners();
  }

///////// get pdf Url
  Future<void> getPdfUrl({
    required Uint8List? pdfFile,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    if (pdfFile == null) {
      onFailure.call();
      return;
    }
    String? url = await _syllabusRepo.uploadPdf(
        pdfFile: pdfFile,
        onSucess: () {
          pdfFile = null;
          onSucess.call();
        },
        onFailure: onFailure);
    if (url != null) {
      pdfUrl = url;
    }

    notifyListeners();
  }

// happen when cancel pdf
  Future<void> cancelPdf({
    required String pdfUrl,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    await _syllabusRepo.deletePdfUrl(
        url: pdfUrl, onSucess: onSucess, onFailure: onFailure);
  }

  void pdfRemove() {
    pdfFile = null;
    pdfUrl = null;
    notifyListeners();
  }

  Future<void> downloadPDF({
    required String url,
    required String fileName,
  }) async {
    await _syllabusRepo.downloadFileWeb(url, fileName);
    notifyListeners();
  }

  //////////////////////////////////////////
  /////5.EXAM SECTION---------------------------------

  List<String> optionNumberList = ['A', 'B', 'C', 'D'];
  ListExamModel? examList;
  ListExamModel? exams;
  List<ExamModel> examData = [];
  List<String> options = [];
  String? droptext;
  ExamModel? editExamData;
  final TextEditingController questionTextController = TextEditingController();
  final TextEditingController optionOneTextController = TextEditingController();
  final TextEditingController optionTwoTextController = TextEditingController();
  final TextEditingController optionThreeTextController =
      TextEditingController();
  final TextEditingController optionFourTextController =
      TextEditingController();
  final TextEditingController answerTextController = TextEditingController();

  ///to get data of all id from section to exam
  SectionModel? selectedSection;
  void selectSectionIdFn(SectionModel section) {
    log('${section.chapterId} ${section.medId} ${section.subId} ${section.stdId}');
    selectedSection = section;
    notifyListeners();
  }

  Future<void> addExamsData({
    required String sectionId,
    required VoidCallback onSucess,
    required void Function(String) onFailure,
  }) async {
    log('Section ID is getting here$sectionId');

    await _syllabusRepo.createNewExamData(
        examModel:
            exams ?? ListExamModel(sectionId: sectionId, examData: examData),
        sectionId: sectionId,
        onSucess: (value) {
          onSucess.call();
          examList = value;
          removeAllExamField();
        },
        onFailure: onFailure);
    notifyListeners();
  }

  ///   1.) to get exam data  from UI------------
  void totalExamModelField(String sectionId) {
    examDataList();

    exams = ListExamModel(
      medId: selectedSection?.medId ?? '',
      stdId: selectedSection?.stdId ?? '',
      subId: selectedSection?.subId ?? '',
      chapterId: selectedSection?.chapterId ?? '',
      sectionId: selectedSection?.id ?? sectionId,
      examData: examData,
    );
    log('Total field 1');
    notifyListeners();
  }

  ///   2.) to get exam data  from UI------------
  void examDataList() {
    //exam model things are added to
    exams = null;
    optionsList();
    answerNumber();
    examData.add(ExamModel(
      id: const Uuid().v1(),
      question: questionTextController.text,
      options: options,
      answer: answerNumber() ?? 5,
    ));
    log('Total field 2');
    notifyListeners();
  }

  ///   3.) to get exam data  from UI------------
  void optionsList() {
    options = [
      optionOneTextController.text,
      optionTwoTextController.text,
      optionThreeTextController.text,
      optionFourTextController.text
    ];
    log('Total field 3');
    notifyListeners();
  }

  ///   4.) to get exam data  from UI  to convert string answer to int------------
  int? answerNumber() {
    log('UUUUUuU  $droptext');
    int index = optionNumberList.indexOf(droptext ?? 'Select option');
    log('Total field 4');
    notifyListeners();
    return index;
  }

  ///   5.) to get exam data  from UI  to convert int answer to string------------
  String answerString(int answerInteger) {
    String value = optionNumberList[answerInteger];
    return value;
  }

  //update exam model
  Future<void> editExam({
    required int index,
    required String sectionId,
    required String fieldId,
    required String key,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    editExamsData(key);
    log(editExamData!.question);
    await _syllabusRepo.updateExamData(
        examData: editExamData!,
        sectionId: sectionId,
        fieldId: fieldId,
        key: key,
        onSucess: (value) {
          examList!.examData.removeAt(index);
          examList!.examData.insert(index, value);
          onSucess.call();
        },
        onFailure: onFailure);
    notifyListeners();
  }

//editing one
  void editExamsData(String? id) {
    optionsList();
    answerNumber();
    editExamData = ExamModel(
        id: id!,
        question: questionTextController.text,
        options: options,
        answer: answerNumber() ?? 5);
    notifyListeners();
  }

  ///set edit data to exam
  void setEditExamData(ExamModel exam) {
    for (int i = 0; i < exam.options.length; i++) {
      optionOneTextController.text = exam.options[0];
      optionTwoTextController.text = exam.options[1];
      optionThreeTextController.text = exam.options[2];
      optionFourTextController.text = exam.options[3];
    }
    questionTextController.text = exam.question;
    droptext = answerString(exam.answer);
  }

////exam delete
  Future<void> deleteExamsData({
    required int index,
    required String sectionId,
    required String fieldId,
    required String key,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    await _syllabusRepo.deleteExam(
        sectionId: sectionId,
        fieldId: fieldId,
        key: key,
        onSucess: () {
          onSucess.call();
          examList!.examData.removeAt(index);
        },
        onFailure: onFailure);
    notifyListeners();
  }

/////////get data
  Future<void> getExamData(
      {required String sectionId,
      required void Function(String) onFailure}) async {
    if (examList != null) return;
    examList =
        await _syllabusRepo.getExam(onFailure: onFailure, sectionId: sectionId);
    notifyListeners();
    log('');
  }

  void removeAllExamField() {
    droptext = null;
    optionOneTextController.clear();
    optionTwoTextController.clear();
    optionThreeTextController.clear();
    optionFourTextController.clear();
    questionTextController.clear();
    exams = null;
    notifyListeners();
  }

/////////////////////////////////////////////////
  ///
  ///
  /// Terms And Condition------------------------------------
  ///
  SectionModel? selectedSectionTerms;
  void selectSectionIdTerms(SectionModel section) {
    selectedSectionTerms = section;
    notifyListeners();
  }

  bool readOnly = false;
  Map<String, dynamic>? terms;
  SectionModel? gotTerms;

  final TextEditingController topicTextController = TextEditingController();
  final TextEditingController totalMarkTextController = TextEditingController();
  final TextEditingController averageMarkTextController =
      TextEditingController();
  final TextEditingController totalquestionTextController =
      TextEditingController();
  String? dropTimeText;

  Map<int, String> totalTime = {
    0: '--select a time--',
    1: '1-Minutes',
    2: '2-Minutes',
    3: '3-Minutes',
    5: '5-Minutes',
    10: '10-Minutes',
    15: '15-Minutes',
    20: '20-Minutes',
    30: '30-Minutes',
    45: '45-Minutes',
    60: '60-Minutes',
  };
  Future<void> updateTermsNCondition({
    required VoidCallback onSucess,
    required void Function(String) onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    // terms = SectionModel(
    //     topic: topicTextController.text,
    //     averageMark: int.parse(averageMarkTextController.text),
    //     numberOfquestion: int.parse(totalquestionTextController.text),
    //     totalMark: int.parse(totalMarkTextController.text),
    //     totalTime: termModelConvertToInteger(dropTimeText!));
    terms = {
      'topic': topicTextController.text,
      'numberOfquestion': int.parse(totalquestionTextController.text),
      'averageMark': int.parse(averageMarkTextController.text),
      'totalMark': int.parse(totalMarkTextController.text),
      'totalTime': termModelConvertToInteger(dropTimeText!)
    };

    log(' $terms');
    await _syllabusRepo.updateNewTermsNCondition(
        terms: terms!,
        sectionId: selectedSectionTerms?.id,
        onSucess: () {
          onSucess.call();
        },
        onFailure: onFailure);
    fetchloading = true;
    notifyListeners();
  }

  // Future<void> getTermsNCondition(
  //     {required String sectionId,
  //     required void Function(String) onFailure}) async {
  //   gotTerms = null;
  //   await _syllabusRepo
  //       .getTermsNCondition(sectionId: sectionId, onFailure: onFailure)
  //       .then(
  //         (terms) => setGetData(terms ?? Se()),
  //       );
  //   notifyListeners();
  //   log('terms and condiion${terms?.id}');
  // }

  /// setting data to the user
  void setGetTermsData(SectionModel selectedSectionTerms) {
    topicTextController.text = selectedSectionTerms.topic ?? '';
    averageMarkTextController.text =
        selectedSectionTerms.averageMark?.toString() ?? '';
    totalquestionTextController.text =
        selectedSectionTerms.numberOfquestion?.toString() ?? '';
    totalMarkTextController.text =
        selectedSectionTerms.totalMark?.toString() ?? '';
    dropTimeText = termModelConvert(selectedSectionTerms.totalTime ?? 0);
    notifyListeners();
  }

  String termModelConvert(int duration) {
    return totalTime[duration]!;
  }

  int termModelConvertToInteger(String duration) {
    for (int key in totalTime.keys) {
      if (totalTime[key] == duration) {
        return key;
      }
    }
    return 0;
  }
}
