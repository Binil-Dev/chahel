import 'dart:developer';
import 'dart:typed_data';
import 'package:chahel_web_1/src/features/notification/model/notification_model.dart';
import 'package:chahel_web_1/src/repository/common_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationController extends ChangeNotifier {
  final Repository _notificationrepo = Repository.instance;
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController contentTextController = TextEditingController();

  Uint8List? imageBytes;
  String? imageUrl;
  bool fetchloading = true;

  Future<void> getImage({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    final image = await _notificationrepo.getGalleryImage(
        onSucess: onSucess, onFailure: onFailure);
    if (image == null) return;
    imageBytes = image;
    notifyListeners();
  }

  Future<void> saveMainImage() async {
    if (imageBytes == null) return;

    String? url = await _notificationrepo.saveImage(
        imageBytes: imageBytes!, onSucess: (val) {}, onFailure: (err) {});

    log("IMAGE URL$url");
    if (url != null) {
      imageUrl = url;
    }
    notifyListeners();
  }

  Future<void> clearStorageImage({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    imageBytes = null;
    if (imageUrl != null) {
      await _notificationrepo.deleteUrl(
          imageUrl: imageUrl, onSucess: onSucess, onFailure: onFailure);
      imageUrl = null;
    }
    notifyListeners();
  }

  void clearImage() {
    imageBytes = null;
    if (imageUrl != null) {
      imageUrl = null;
    }
    notifyListeners();
  }

///////add notification
  NotificationModel? notification;

  Future<void> addNotification({
    required void Function(String) onSucess,
    required VoidCallback onFailure,
  }) async {
    notifyListeners();
    notification = NotificationModel(
        image: imageUrl,
        title: titleTextController.text,
        content: contentTextController.text,
        timestamp: Timestamp.now());
    await _notificationrepo.addNotification(
        notification: notification!, onSucess: onSucess, onFailure: onFailure);
    fetchloading = true;
    notifyListeners();
  }

  void clearAllNotificationFields() {
    notification = null;
    contentTextController.clear();
    titleTextController.clear();
    clearImage();
    notifyListeners();
  }
}
