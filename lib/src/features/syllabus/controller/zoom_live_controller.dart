import 'dart:developer';

import 'package:chahel_web_1/src/features/syllabus/model/zoom_live.dart';
import 'package:chahel_web_1/src/repository/common_repository.dart';
import 'package:flutter/material.dart';

class ZoomLiveController extends ChangeNotifier {
  final Repository _repo = Repository.instance;

  final TextEditingController? controllerLiveUrl = TextEditingController();

  bool? isliveNow = false;

  ZoomLiveModel? liveDetails;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

//add live link
  Future<void> addLiveDetails({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
  
    liveDetails = ZoomLiveModel(
        isLiveNow: isliveNow, link: controllerLiveUrl?.text ?? '');
       log(isliveNow.toString());
    log(controllerLiveUrl!.text);   
    await _repo.setLive(
        liveLink: liveDetails ?? ZoomLiveModel(),
        onSucess: (value) {
          onSucess.call(value);
          liveDetails = null;
        },
        onFailure: onFailure);
    notifyListeners();
  }

//get live link

  Future<void> getLiveDetails({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    if (liveDetails == null) {
      liveDetails =
          await _repo.getLive(onSucess: onSucess, onFailure: onFailure);
      controllerLiveUrl?.text = liveDetails?.link ?? 'No live link added';
      isliveNow = liveDetails?.isLiveNow;
      notifyListeners();
    }
  }
}
