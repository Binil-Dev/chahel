import 'dart:developer';
import 'package:chahel_web_1/src/features/syllabus/model/chapter_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/exam_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/medium_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/section_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/standard_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/subject_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;

class SyllabusRepository {
  SyllabusRepository._();

  static final SyllabusRepository _instance = SyllabusRepository._();

  static SyllabusRepository get instance => _instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Syllabus section
/////////////////////////////////////////////////////////////////////////////////////////
  final collectionReferrenceStandard =
      FirebaseFirestore.instance.collection('standards');
  final collectionReferrenceMedium =
      FirebaseFirestore.instance.collection('medium');
  final collectionReferrenceSubject =
      FirebaseFirestore.instance.collection('subjects');
  final collectionReferrenceChapter =
      FirebaseFirestore.instance.collection('chapter');
  final collectionReferrenceSection =
      FirebaseFirestore.instance.collection('section');
  final collectionReferrenceExams =
      FirebaseFirestore.instance.collection('exams');

  // 1. standards

///////////////////////////////////////////////////////////////////////////

  Future<void> createNewStandards({
    required StandardsModel standards,
    required void Function(StandardsModel) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      final refernence =
          await collectionReferrenceStandard.add(standards.toMap());
      onSucess(standards.copyWith(id: refernence.id));
    } catch (e) {
      onFailure("Couldn't able add the standard");
    }
  }

  Future<void> updateStandards({
    required StandardsModel model,
    required String? id,
    required void Function(StandardsModel) onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrenceStandard.doc(id).update(model.toMap());

      onSucess(model.copyWith(id: id));
    } catch (e) {
      onFailure.call();
    }
  }

  Future<void> deleteStandards({
    String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrenceStandard.doc(id).delete();
      onSucess.call();
    } catch (e) {
      onFailure.call();
    }
  }

  Future<List<StandardsModel>?> getStandards(
      {required void Function(String) onFailure}) async {
    try {
      final snapshot = await collectionReferrenceStandard
          .orderBy('isCreated', descending: false)
          .get();
      return [
        ...snapshot.docs
            .map((e) => StandardsModel.fromMap(e.data()).copyWith(id: e.id))
      ];
    } catch (e) {
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

  //2.MEDIUM

//////////////////////////////////////////////////////////////////////////////
  Future<void> createNewMedium({
    required MediumModel medium,
    required void Function(MediumModel) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      log('Medium create');
      final refernence = await collectionReferrenceMedium.add(medium.toMap());
      onSucess(medium.copyWith(id: refernence.id));
    } catch (e) {
      onFailure("Couldn't able add the medium");
    }
  }

  Future<void> updateMedium({
    required MediumModel model,
    required String? id,
    required void Function(MediumModel) onSucess,
    required VoidCallback onFailure,
  }) async {
    log('Medium edit');
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrenceMedium.doc(id).update(model.toMap());
      onSucess(model.copyWith(id: id));
    } catch (e) {
      onFailure.call();
    }
  }

  Future<void> deleteMedium({
    String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrenceMedium.doc(id).delete();
      onSucess.call();
    } catch (e) {
      onFailure.call();
    }
  }

  Future<List<MediumModel>?> getMedium({
    required void Function(String) onFailure,
    required String stdId,
  }) async {
    try {
      log(stdId);
      final snapshot = await collectionReferrenceMedium
          .orderBy(
            'timestamp',
          )
          .where('stdId', isEqualTo: stdId)
          // Specify the field to order by
          .get();

      log(snapshot.docs.length.toString());
      return [
        ...snapshot.docs
            .map((e) => MediumModel.fromMap(e.data()).copyWith(id: e.id))
      ];
    } on FirebaseException catch (e) {
      log(e.toString());
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

// to get to check from standard that medium is empty
  Future<bool> getMediumBool(
      {required void Function(String) onFailure, required String stdId}) async {
    try {
      log(stdId);
      final snapshot = await collectionReferrenceMedium
          .where('stdId', isEqualTo: stdId)
          .get();

      log(snapshot.docs.length.toString());

      return snapshot.docs.isEmpty;
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able to get the details inside the current standard");
    }
    return false;
  }
  //////////////////////////////////////////
  /// 3. SUBJECT

  Future<void> createNewSubject({
    required SubjectModel subject,
    required void Function(SubjectModel) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      final refernence = await collectionReferrenceSubject.add(subject.toMap());
      onSucess(subject.copyWith(id: refernence.id));
    } catch (e) {
      onFailure("Couldn't able add the medium");
    }
  }

  Future<void> updateSubject({
    required SubjectModel model,
    required String? id,
    required void Function(SubjectModel editSubject) onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrenceSubject.doc(id).update(model.toMap());
      onSucess.call(model.copyWith(id: id));
    } catch (e) {
      onFailure.call();
    }
  }

  Future<void> deleteSubject({
    String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrenceSubject.doc(id).delete();
    } catch (e) {
      onFailure.call();
    }
  }

  Future<List<SubjectModel>?> getSubject(
      {required void Function(String) onFailure, required String medId}) async {
    try {
      final snapshot = await collectionReferrenceSubject
          .where('medId', isEqualTo: medId)
          .orderBy('isCreated', descending: false)
          .get();
      return [
        ...snapshot.docs
            .map((e) => SubjectModel.fromMap(e.data()).copyWith(id: e.id))
      ];
    } on FirebaseException catch (e) {
      print(e.toString());
      onFailure("Couldn't able to get the subject");
    } catch (e) {
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

  // to get to check from medium that subject is empty
  Future<bool> getSubjectBool(
      {required void Function(String) onFailure, required String medId}) async {
    try {
      final snapshot = await collectionReferrenceSubject
          .where('medId', isEqualTo: medId)
          .get();
      return snapshot.docs.isEmpty;
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able to get the details inside the current medium");
    }
    return false;
  }

  //////////////////////////////////////////
  /// 4. CHAPTER

  Future<void> createNewChapter({
    required ChapterModel chapter,
    required void Function(ChapterModel) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      final refernence = await collectionReferrenceChapter.add(chapter.toMap());
      onSucess(chapter.copyWith(id: refernence.id));
    } catch (e) {
      onFailure("Couldn't able add the chapter");
    }
  }

  Future<void> updateChapter({
    required ChapterModel model,
    required String? id,
    required void Function(ChapterModel editChapter) onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrenceChapter.doc(id).update(model.toMap());
      onSucess.call(model.copyWith(id: id));
    } catch (e) {
      onFailure.call();
    }
  }

  Future<void> deleteChapter({
    String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrenceChapter.doc(id).delete();
    } catch (e) {
      onFailure.call();
    }
  }

  Future<List<ChapterModel>?> getChapter(
      {required void Function(String) onFailure, required String subId}) async {
    try {
      final snapshot = await collectionReferrenceChapter
          .where('subId', isEqualTo: subId)
          .orderBy('sectionNumber')
          .get();
      return [
        ...snapshot.docs
            .map((e) => ChapterModel.fromMap(e.data()).copyWith(id: e.id))
      ];
    } on FirebaseException catch (e) {
      print(e.toString());
      onFailure("Couldn't able to get the chapters");
    } catch (e) {
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

// to get to check from subject that chapter is empty
  Future<bool> getChapterBool(
      {required void Function(String) onFailure, required String subId}) async {
    try {
      final snapshot = await collectionReferrenceChapter
          .where('subId', isEqualTo: subId)
          .get();
      return snapshot.docs.isEmpty;
    } catch (e) {
      onFailure("Couldn't able to get the details inside the current subject");
    }
    return false;
  }
  //////////////////////////////////////////
  /// 5. SECTION

  Future<void> createNewSection({
    required SectionModel section,
    required void Function(SectionModel) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      final refernence = await collectionReferrenceSection.add(section.toMap());
      onSucess(section.copyWith(id: refernence.id));
    } catch (e) {
      onFailure("Couldn't able add the section");
    }
  }

//update the chapter
  Future<void> updateSection({
    required SectionModel model,
    required String? id,
    required void Function(SectionModel) onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrenceSection.doc(id).update(model.toMap());
      onSucess.call(model.copyWith(id: id));
    } catch (e) {
      onFailure.call();
    }
  }

  ///delete chapter
  Future<void> deleteSection({
    required String? sectionId,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (sectionId == null) {
        return onFailure.call();
      }
      await collectionReferrenceSection.doc(sectionId).delete();
    } catch (e) {
      onFailure.call();
    }
  }

  ///get chapter
  Future<List<SectionModel>?> getSection(
      {required void Function(String) onFailure,
      required String chapterId}) async {
    try {
      final snapshot = await collectionReferrenceSection
          .where('chapterId', isEqualTo: chapterId)
          .orderBy('sectionNumber')
          .get();
      return [
        ...snapshot.docs
            .map((e) => SectionModel.fromMap(e.data()).copyWith(id: e.id))
      ];
    } on FirebaseException catch (e) {
      print(e.toString());
      onFailure("Couldn't able to get the  sections");
    } catch (e) {
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

  // to get to check from chapter that section is empty
  Future<bool> getSectionBool(
      {required void Function(String) onFailure,
      required String chapterId}) async {
    try {
      final snapshot = await collectionReferrenceSection
          .where('chapterId', isEqualTo: chapterId)
          .get();
      return snapshot.docs.isEmpty;
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able to get the details inside the current chapter");
    }
    return false;
  }

///////////////////////   PDF section------------------------------------
  ///
  ///

  Future<Uint8List?> getPdfFile({
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    final FilePickerResult? pickedFile;

    try {
      pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      log(pickedFile.toString());
      if (pickedFile != null && pickedFile.files.isNotEmpty) {
        PlatformFile file = pickedFile.files.first;
        Uint8List pdfFile = file.bytes!;
        onSucess.call();
        return pdfFile;
      }
    } catch (e) {
      onFailure.call();
    }
    return null;
  }

  Future<String?> uploadPdf({
    required Uint8List pdfFile,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    final String pdfName = 'pdf/${DateTime.now().microsecondsSinceEpoch}.pdf';
    final String? downloadPdfUrl;
    try {
      await _storage
          .ref(pdfName)
          .putData(pdfFile, SettableMetadata(contentType: 'file/pdf'));
      downloadPdfUrl = await _storage.ref(pdfName).getDownloadURL();
      onSucess.call();
      return downloadPdfUrl;
    } catch (e) {
      onFailure.call();
    }
    return null;
  }

  Future<void> deletePdfUrl({
    required String? url,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    if (url == null) return;
    final pdfRef = _storage.refFromURL(url);
    try {
      await pdfRef.delete();

      onSucess.call();
    } catch (e) {
      onFailure.call();
    }
  }

// PDF DOWNLOAD SECTION

  Future<void> downloadFileWeb(String url, String fileName) async {
    final httpsReference = FirebaseStorage.instance.refFromURL(url);
    html.window.open(url, "_blank");
    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await httpsReference.getData(oneMegabyte);
      // Data for "images/island.jpg" is returned, use this as needed.
      XFile.fromData(data!,
              mimeType: "application/octet-stream", name: fileName + ".pdf")
          .saveTo("C:/"); // here Path is ignored
      //opens pdf in new tab
    } on FirebaseException catch (e) {
      print(e.toString());
      // Handle any errors.
    }
    // for other platforms see this solution : https://firebase.google.com/docs/storage/flutter/download-files#download_to_a_local_file
  }

  //////////////////////////////////////////////////
  /// EXAMS

  Future<void> createNewExamData({
    required ListExamModel examModel,
    required String sectionId,
    required void Function(ListExamModel) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      await collectionReferrenceExams.doc(sectionId).set(examModel.toMap());
      onSucess(examModel.copyWith(sectionId: sectionId));
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able add the exam");
    }
  }

  Future<void> updateExamData({
    required ExamModel examData,
    required String? sectionId,
    required String? fieldId,
    required String? key,
    required void Function(ExamModel) onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (sectionId == null) {
        return onFailure.call();
      }
      log('$key', name: 'key');
      log('$fieldId', name: 'fieldId');
      await collectionReferrenceExams.doc(sectionId).update(
        {'$fieldId.$key': examData.toMap()},
      );
      onSucess.call(examData);
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure.call();
    }
  }

  Future<void> deleteExam({
    required String? sectionId,
    required String? fieldId,
    required String? key,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (sectionId == null) {
        return onFailure.call();
      }
      await collectionReferrenceExams
          .doc(sectionId)
          .update({'$fieldId.$key': FieldValue.delete()});
      onSucess.call();
    } catch (e) {
      onFailure.call();
    }
  }

  Future<ListExamModel?> getExam(
      {required void Function(String) onFailure,
      required String sectionId}) async {
    try {
      final snapshot = await collectionReferrenceExams.doc(sectionId).get();
      log(snapshot.id);
      return ListExamModel.fromMap(snapshot.data()!);
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able to get the details");
    }
    return null;
  }
  // to get to check from chapter that section is empty

  Future<bool> getExamBool(
      {required void Function(String) onFailure,
      required String sectionId}) async {
    try {
      final snapshot = await collectionReferrenceExams.doc(sectionId).get();
      log(snapshot.id);
      return snapshot.exists;
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able to get the details inside the current section");
    }
    return true;
  }
//////////////////////////////////////////////////////////////////

///////  Terms and Conditions----------------------------------------
  ///
  Future<void> updateNewTermsNCondition({
    required String? sectionId,
    required Map<String, dynamic>? terms,
    required void Function() onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      await collectionReferrenceSection.doc(sectionId).update(terms!);
      onSucess.call();
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able save the terms and condition");
    }
  }

  // Future<TermsAndConditionModel?> getTermsNCondition({
  //   required String? sectionId,
  //   required void Function(String) onFailure,
  // }) async {
  //   try {
  //     final snapshot =
  //         await collectionReferrenceTermsAndConditionModel.doc(sectionId).get();
  //     return TermsAndConditionModel.fromMap(snapshot.data()!)
  //         .copyWith(id: snapshot.id);
  //   } catch (e) {
  //     onFailure("Couldn't able to get the terms and condition");
  //   }
  //   return null;
  // }
}
