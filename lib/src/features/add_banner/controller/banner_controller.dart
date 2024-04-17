import 'dart:developer';
import 'dart:typed_data';
import 'package:chahel_web_1/src/features/add_banner/model/banner_model.dart';
import 'package:chahel_web_1/src/repository/common_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerController extends ChangeNotifier {
  final Repository _bannerRepo = Repository.instance;

  List<BannerModel> bannerList = [];
  BannerModel? banners;
  bool fetchloading = true;
//get image
  Uint8List? imageBytes;
  String? imageUrl;

////  IMAGE SECTION

//get image

  Future<void> getImage({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    imageUrl = null;
    final image = await _bannerRepo.getGalleryImage(
        onSucess: onSucess, onFailure: onFailure);
    if (image == null) return;
    imageBytes = image;

    notifyListeners();
  }

  //save image
  Future<void> saveMainImage({
    required Uint8List imagepath,
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    imageUrl = await _bannerRepo.saveImage(
        imageBytes: imagepath, onSucess: onSucess, onFailure: onFailure);

    notifyListeners();
  }

//delete Image from storage
  Future<void> clearStorageImage({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    imageBytes = null;
    onSucess;
    if (imageUrl != null) {
      await _bannerRepo.deleteUrl(
          imageUrl: imageUrl!, onSucess: onSucess, onFailure: onFailure);
      imageUrl = null;
    }
    notifyListeners();
  }

//clear image
  Future<void> clearImage({
    VoidCallback? onSucess,
    VoidCallback? onFailure,
  }) async {
    imageBytes = null;
    onSucess;
    if (imageUrl != null) {
      imageUrl = null;
    }

    notifyListeners();
  }

//Firestore section to add delete update

//create a new banner
  Future<void> addNewBanner({
    required VoidCallback onSucess,
    required void Function(String) onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    if (imageUrl == null) {
      onFailure;
      return;
    }
    banners = BannerModel(image: imageUrl ?? '', timestamp: Timestamp.now());
    await _bannerRepo.addBanner(
        bannerDetails: banners!,
        onSucess: (value) {
          bannerList.insert(bannerList.length, value);
          onSucess.call();
          notifyListeners();
          log('image firestore');
        },
        onFailure: onFailure);
    fetchloading = true;
    notifyListeners();
  }

//delete banner
  Future<void> deleteBanner({
    int? index,
    String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    await _bannerRepo.deleteBanner(
        id: id,
        onSucess: () {
          bannerList.removeAt(index!);
          onSucess.call();
          notifyListeners();
        },
        onFailure: onFailure);
    notifyListeners();
  }

// update banner
  Future<void> editBanner({
    required String? id,
    required int index,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    banners = BannerModel(image: imageUrl ?? '', timestamp: Timestamp.now());
    await _bannerRepo.updateBanner(
      model: banners!,
      id: id,
      onSucess: (value) {
        log('index to remove the banner $index');
        bannerList.removeAt(index);
        bannerList.insert(index, value);
        onSucess.call();
        notifyListeners();
      },
      onFailure: onFailure,
    );
    fetchloading = true;
    notifyListeners();
  }

  void setEditBanner(BannerModel banner) {
    imageUrl = banner.image;
    notifyListeners();
  }

  //get the banner
  Future<void> getBanner({required void Function(String) onFailure}) async {
    bannerList.clear();
        fetchloading = false;
    notifyListeners();
    await _bannerRepo.getDetails(onFailure: onFailure).then((value) {
      bannerList.addAll(value ?? []);
      log('get banner');
       fetchloading = true;
      notifyListeners();
    });
  }
}
