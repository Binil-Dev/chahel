import 'package:chahel_web_1/src/features/add_banner/screen/banner.dart';
import 'package:chahel_web_1/src/features/notification/screen/notification.dart';
import 'package:chahel_web_1/src/features/payment_gateway/screen/payment.dart';
import 'package:chahel_web_1/src/features/plans/screen/plan.dart';
import 'package:chahel_web_1/src/features/plans/screen/plan_medium.dart';
import 'package:chahel_web_1/src/features/plans/screen/plan_standard.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/chapter.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/exam.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/medium.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/section.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/subject.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/syllabus.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/terms_condition.dart';
import 'package:chahel_web_1/src/features/users/screen/user.dart';
import 'package:flutter/material.dart';

class NavigationController extends ChangeNotifier {
  int pageIndex = 0;
  int subpageIndex = 0;

  List<List<Widget>> pages = [
    [const UserScreen()],
    [
      const SyllabusScreen(),
      const MediumScreen(),
      const SubjectScreen(),
      const ChapterScreen(),
      const SectionScreen(),
      const ExamScreen(),
      const TermsNConditionScreen(),
    ],
    [const PlansStandardScreen(), const PlanMediumScreen(), const PlanScreen()],
    [const BannerScreen()],
    [const NotificationScreen()],
    [const PaymentScreen()],
  ];

  void setSubPageIndex(int index) {
    subpageIndex = index;
    notifyListeners();
  }

  void setPageIndex(int index) {
    pageIndex = index;
    subpageIndex = 0;
    notifyListeners();
  }
}
