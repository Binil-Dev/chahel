//plan---------------------

import 'dart:developer';
import 'package:chahel_web_1/src/features/plans/model/plan_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/medium_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/standard_model.dart';
import 'package:chahel_web_1/src/repository/common_repository.dart';
import 'package:flutter/material.dart';

class PlanController extends ChangeNotifier {
  final Repository _planRepo = Repository.instance;
  PlanModel? plan;
  List<PlanModel?> planList = [];
  final TextEditingController mediumController = TextEditingController();
  final TextEditingController standardController = TextEditingController();
  final TextEditingController cashController = TextEditingController();
  String? dropPlanText;

  final Map<int, String> planMonthMap = {
    0: '-- Select period --',
    1: 'One month',
    12: 'Twelve months',
  };

  MediumModel? selectedMedium;
  StandardsModel? selectedStandard;
  //select medium to pass the id in medium to plan
  void selectedMedStdId(MediumModel medium, StandardsModel standard) {
    selectedMedium = medium;
    selectedStandard = standard;
    notifyListeners();
  }

  void setDataPlan() {
    mediumController.text = selectedMedium?.medium ?? '';
    standardController.text = selectedStandard?.standard ?? '';
    notifyListeners();
  }

  int planDurationConvertToInteger(String duration) {
    for (int key in planMonthMap.keys) {
      if (planMonthMap[key] == duration) {
        return key;
      }
    }
    return 0;
  }
// create plan
  Future<void> addNewPlan({
    required VoidCallback onSucess,
    required void Function(String) onFailure,
  }) async {
    plan = PlanModel(
      stdId: selectedMedium!.stdId,
      medId: selectedMedium?.id ?? '',
      medium: selectedMedium!.medium,
      standard: selectedStandard?.standard ?? '',
      planDuration: planDurationConvertToInteger(dropPlanText!),
      totalAmount: int.parse(cashController.text),
    );
    await _planRepo.createNewPlan(
        plan: plan!,
        onSucess: (value) {
          planList.insert(0, value);
          onSucess.call();
          notifyListeners();
          log('plan firestore');
        },
        onFailure: onFailure);
  }

  //clear plan
  void clearPlanFields() {
    plan = null;
    mediumController.clear();
    standardController.clear();
    cashController.clear();
    dropPlanText = null;
    notifyListeners();
  }

//delete plan
  Future<void> planDelete({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    await _planRepo.deletePlan(
        id: id,
        onSucess: () {
          planList.removeAt(index);
          onSucess.call();
        },
        onFailure: onFailure);
    notifyListeners();
  }

// update plan
  Future<void> planUpdate({
    required int index,
    required String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    plan = PlanModel(
      stdId: selectedMedium!.stdId,
      medId: selectedMedium?.id ?? '',
      medium: selectedMedium!.medium,
      standard: selectedStandard?.standard ?? '',
      planDuration: planDurationConvertToInteger(dropPlanText!),
      totalAmount: int.parse(cashController.text),
    );
    await _planRepo.updatePlan(
      plan: plan!,
      id: id,
      //value is plan
      onSucess: (value) {
        planList.removeAt(index);
        planList.insert(0, value);
        onSucess.call();
      },
      onFailure: onFailure,
    );
    notifyListeners();
  }

//- edit plan function

  void setEditDataPlan(PlanModel planEditModel) {
    mediumController.text = planEditModel.medium ?? '';
    standardController.text = planEditModel.standard ?? '';
    cashController.text = (planEditModel.totalAmount).toString();
    dropPlanText = planDurationConvert(planEditModel.planDuration ?? 0);
    notifyListeners();
  }

  String planDurationConvert(int duration) {
    return planMonthMap[duration]!;
  }

  //get the plan
  Future<void> getPlanList(
      {required void Function(String) onFailure,
      required String stdId,
      required String medId}) async {
    planList.clear();
    await _planRepo
        .getPlan(stdId: stdId, medId: medId, onFailure: onFailure)
        .then((value) {
      planList.addAll((value ?? []));
      log('get standards');
      notifyListeners();
    });
  }
}
