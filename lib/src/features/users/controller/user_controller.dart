import 'dart:developer';

import 'package:chahel_web_1/src/features/plans/model/plan_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/medium_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/standard_model.dart';
import 'package:chahel_web_1/src/features/users/model/user_model.dart';
import 'package:chahel_web_1/src/repository/common_repository.dart';
import 'package:chahel_web_1/src/repository/syllabus_repo.dart';
import 'package:chahel_web_1/src/repository/users_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final Repository _userRepo = Repository.instance;
  final SyllabusRepository _syllabusRepo = SyllabusRepository.instance;

  List<UserModel> allUser = [];
  bool fetchloading = true;
  int tabIndex = 0;

  void changeTabINdex({required int index, required String? searchText}) {
    tabIndex = index;
    UsersRepo.clearData();
    allUser = [];
    fetchAllUsers(search: searchText);

    notifyListeners();
  }

  void searchUsers(String search) {
    UsersRepo.clearData();
    allUser = [];
    fetchAllUsers(search: search);
    notifyListeners();
  }

//fetch all users

  Future<void> fetchAllUsers({
    required String? search,
  }) async {
    fetchloading = false;
    notifyListeners();
    final getUsers =
        await UsersRepo.fetchAllUsers(search: search, tabIndex: tabIndex);
    allUser.addAll(getUsers);
    fetchloading = true;
    notifyListeners();
  }

////////////////
  ///  PLan selection section----------------------
  ///
  ///
  final TextEditingController planPriceController = TextEditingController();

  List<StandardsModel>? standardsList = [];
  List<MediumModel>? mediumsList = [];
  String? dropStandardId;
  String? dropMediumId;
  String? dropPlanText;
  // this plan works according  to the value from the drop down
  PlanModel? plans;
  //here in the plan  we get all the plan model details that is already set
  PlanModel? plan;
  List<PlanModel?> planList = [];
  Future<void> getStandardsList(
      {required void Function(String) onFailure}) async {
    plan = null;
    standardsList?.clear();
    planList.clear();
    planPriceController.clear();
    dropStandardId = null;
    await _syllabusRepo.getStandards(onFailure: onFailure).then((value) {
      standardsList = value ?? [];
      log('get standards');
      notifyListeners();
    });
  }

  Future<void> getMediumList(
      {required void Function(String) onFailure, required String stdId}) async {
    plan = null;
    dropMediumId = null;
    mediumsList?.clear();
    planList.clear();
    planPriceController.clear();
    await _syllabusRepo
        .getMedium(stdId: stdId, onFailure: onFailure)
        .then((value) {
      mediumsList = value ?? [];
      log('get standards');
      log("MEDUIM LIST${mediumsList?.length}");

      notifyListeners();
    });
  }

  /// getting plan model
  Future<void> getPlanList(
      {required void Function(String) onFailure,
      required String stdId,
      required String medId}) async {
    planList.clear();
    planPriceController.clear();
    plan = null;
    await _userRepo
        .getPlan(stdId: stdId, medId: medId, onFailure: onFailure)
        .then((value) {
      planList = value ?? [];
      log('get plan in user');
      notifyListeners();
    });
  }

//to covert plan to integer according to the month selected from the dropdown
  final Map<int, String> planMonthMap = {
    0: '-- Select period --',
    1: 'One month',
    12: 'Twelve months',
    3: 'No plan available'
  };

  int planDurationConvertToInteger(String duration) {
    for (int key in planMonthMap.keys) {
      if (planMonthMap[key] == duration) {
        return key;
      }
    }
    return 0;
  }

  String planDurationConvert(int duration) {
    return planMonthMap[duration]!;
  }

  void clearPlanDetails() {
    mediumsList?.clear();
    planList.clear();
    dropStandardId = null;
    dropMediumId = null;
    dropPlanText = null;
    planPriceController.clear();
    plan = null;
    plans = null;
    notifyListeners();
  }

// updating plan details in user model
  Future<void> updateUserPlan({
    required String? id,
    required void Function() onSucess,
    required VoidCallback onFailure,
  }) async {
    plans = PlanModel(
        stdId: dropStandardId,
        medId: dropMediumId,
        standard: plan?.standard ?? '',
        medium: plan?.medium ?? '',
        totalAmount: plan?.totalAmount,
        userId: id,
        startDate: Timestamp.now(),
        endDate: (plan?.planDuration == 1)
            ? Timestamp.fromMillisecondsSinceEpoch(
                Timestamp.now().millisecondsSinceEpoch +
                    30 * 24 * 60 * 60 * 1000)
            : Timestamp.fromMillisecondsSinceEpoch(
                Timestamp.now().millisecondsSinceEpoch +
                    365 * 24 * 60 * 60 * 1000),
        planDuration: plan?.planDuration);
    await _userRepo.updateUserPlan(
        userPlan: plans ?? PlanModel(),
        id: id,
        onFailure: () {
          clearPlanDetails();
          onFailure.call();
        },
        onSucess: (value) {
          clearPlanDetails();
          onSucess.call();
        });

    notifyListeners();
  }

  //// updating  user to make the user active or passive is active when false
  bool isactive = false;

  void isUserActive(bool userActive) {
    isactive = userActive;
    log(isactive.toString());
    notifyListeners();
  }

  Future<void> updateUserActive({
    required String? id,
    required void Function() onSucess,
    required VoidCallback onFailure,
  }) async {
    await _userRepo.updateUser(
        userActive: isactive,
        id: id,
        onSucess: (value) async {
          onSucess.call();
        },
        onFailure: onFailure);
  }
}
