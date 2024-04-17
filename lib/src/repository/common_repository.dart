import 'dart:developer';

import 'package:chahel_web_1/src/features/add_banner/model/banner_model.dart';
import 'package:chahel_web_1/src/features/notification/model/notification_model.dart';
import 'package:chahel_web_1/src/features/payment_gateway/model/payment_model.dart';
import 'package:chahel_web_1/src/features/plans/model/plan_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/zoom_live.dart';
import 'package:chahel_web_1/src/features/users/model/user_model.dart';
import 'package:chahel_web_1/src/utils/constants/text/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class Repository {
  Repository._();

  static final Repository _instance = Repository._();

  static Repository get instance => _instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

//Image Picker-------------------------------------

//pick image
  final ImagePicker picker = ImagePicker();
  Future<Uint8List?> getGalleryImage({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    final XFile? pickedImageFile;
    final Uint8List? imageBytes;
    try {
      pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImageFile != null) {
        imageBytes = await pickedImageFile.readAsBytes();
        onSucess.call(BText.imageGetSucess);
        return imageBytes;
      } else {
        onFailure.call(BText.imageGetError);
      }
    } catch (e) {
      onFailure.call(BText.imageGetError);
    }
    return null;
  }

//save image

  Future<String?> saveImage({
    required Uint8List imageBytes,
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    final String imageName =
        'courseImage/${DateTime.now().microsecondsSinceEpoch}.png';
    final String? downloadUrl;
    try {
      await _storage
          .ref(imageName)
          .putData(imageBytes, SettableMetadata(contentType: 'image/png'));
      downloadUrl = await _storage.ref(imageName).getDownloadURL();
      onSucess.call(BText.imageUrlSucess);
      return downloadUrl;
    } catch (e) {
      onFailure.call(BText.imageUrlError);
    }
    return null;
  }

//delete Image

  Future<void> deleteUrl({
    required String? imageUrl,
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    if (imageUrl == null) return;
    final imageRef = _storage.refFromURL(imageUrl);
    try {
      await imageRef.delete();
      onSucess.call(BText.imageDeletSucess);
    } catch (e) {
      onFailure.call(BText.imageDeleteError);
    }
  }

////////////// Add Banner----------------------------------
  ///
  final collectionReferenceBanner =
      FirebaseFirestore.instance.collection('banners');

  Future<void> addBanner({
    required BannerModel bannerDetails,
    required void Function(BannerModel) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      final reference =
          await collectionReferenceBanner.add(bannerDetails.toMap());

      onSucess.call(bannerDetails.copyWith(id: reference.id));
    } on FirebaseException catch (e) {
      log('Payment set ${e.code}');
      onFailure.call(BText.bannerAddError);
    } catch (e) {
      log('Payment set $e');
      onFailure.call(BText.bannerAddError);
    }
  }

  // Future<PaymentModel?> getBanner({
  //   required String id,
  //   required void Function(String) onSucess,
  //   required void Function(String) onFailure,
  // }) async {
  //   try {
  //     final paymentDetails =
  //         await collectionReferenceBanner.doc(paymentId).get();

  //     onSucess.call(BText.paymentGetSucess);
  //     return PaymentModel.fromMap(paymentDetails.data() ?? <String, dynamic>{});
  //   } on FirebaseException catch (e) {
  //     log('Payment get ${e.toString()}');
  //     onFailure.call(BText.paymentGetError);
  //   } catch (e) {
  //     log('Payment set $e');
  //     onFailure.call(BText.paymentGetError);
  //   }
  //   return null;
  // }

  Future<void> updateBanner({
    required BannerModel model,
    required String? id,
    required void Function(BannerModel) onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferenceBanner.doc(id).update(model.toMap());
      onSucess.call(model.copyWith(id: id));
    } catch (e) {
      onFailure.call();
    }
  }

  Future<void> deleteBanner({
    String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferenceBanner.doc(id).delete();
      onSucess.call();
    } catch (e) {
      onFailure.call();
    }
  }

  Future<List<BannerModel>?> getDetails(
      {required void Function(String) onFailure}) async {
    try {
      final snapshot =
          await collectionReferenceBanner.orderBy('timestamp').get();
      return [
        ...snapshot.docs
            .map((e) => BannerModel.fromMap(e.data()).copyWith(id: e.id))
      ];
    } catch (e) {
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

////////////// Payment_gateway -------------------------
  final collectionReferencePayment =
      FirebaseFirestore.instance.collection('payment_gateway');

  String paymentId = 'payment_phonepe';

//payment set
  Future<void> setPayment({
    required PaymentModel paymentDetails,
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      log(
        paymentDetails.merchantId.toString(),
      );
      await collectionReferencePayment
          .doc(paymentId)
          .set(paymentDetails.toMap());
      onSucess.call(BText.paymentsetSucess);
    } on FirebaseException catch (e) {
      log('Payment set ${e.code}');
      onFailure.call(BText.paymentsetError);
    } catch (e) {
      log('Payment set $e');
      onFailure.call(BText.paymentsetError);
    }
  }

  Future<PaymentModel?> getPayment({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      log('1....');
      final paymentDetails =
          await collectionReferencePayment.doc(paymentId).get();

      onSucess.call(BText.paymentGetSucess);
      return PaymentModel.fromMap(paymentDetails.data() ?? <String, dynamic>{});
    } on FirebaseException catch (e) {
      log('Payment get ${e.toString()}');
      onFailure.call(BText.paymentGetError);
    } catch (e) {
      log('Payment set $e');
      onFailure.call(BText.paymentGetError);
    }
    return null;
  }

  ///////////////////////////////////////////////////

  /*PLAN REPOSITORY FROM HERE -----------------------------------------*/

//////////////////////////////////////////////////////////////////////////////
  final collectionReferrencePlan =
      FirebaseFirestore.instance.collection('plan');

  Future<void> createNewPlan({
    required PlanModel plan,
    required void Function(PlanModel) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      final refernence = await collectionReferrencePlan.add(plan.toMap());
      onSucess(plan.copyWith(id: refernence.id));
    } catch (e) {
      onFailure("Couldn't able add the medium");
    }
  }

  Future<void> updatePlan({
    required PlanModel plan,
    required String? id,
    required void Function(PlanModel) onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrencePlan.doc(id).update(plan.toMap());
      onSucess(plan.copyWith(id: id));
    } catch (e) {
      onFailure.call();
    }
  }

  Future<void> deletePlan({
    String? id,
    required VoidCallback onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      await collectionReferrencePlan.doc(id).delete();
      onSucess.call();
    } catch (e) {
      onFailure.call();
    }
  }

  Future<List<PlanModel>?> getPlan(
      {required void Function(String) onFailure,
      required String stdId,
      required String medId}) async {
    try {
      log(stdId);
      log(medId);
      final snapshot = await collectionReferrencePlan
          .where(Filter.and(Filter('stdId', isEqualTo: stdId),
              Filter('medId', isEqualTo: medId)))
          .get();

      log(snapshot.docs.length.toString());
      return [
        ...snapshot.docs
            .map((e) => PlanModel.fromMap(e.data()).copyWith(id: e.id))
      ];
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

////////////// USER DETAILS--------------------------------------------
  ///
  ///
  ///
  final collectionReferrenceUser =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUser({
    required bool userActive,
    required String? id,
    required void Function(bool) onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }

      await collectionReferrenceUser
          .doc(id)
          .update({'isUserActive': userActive});
      onSucess.call(userActive);
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure.call();
    }
  }

  Future<void> updateUserPlan({
    required PlanModel userPlan,
    required String? id,
    required void Function(PlanModel) onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      if (id == null) {
        return onFailure.call();
      }
      log('The item is got herere to add $id');
      await collectionReferrenceUser.doc(id).update({
        'purchaseDetails': FieldValue.arrayUnion([userPlan.toMap()])
      });
      onSucess.call(userPlan);
    } on FirebaseException catch (e) {
      log(e.message!);
      onFailure.call();
    }
  }

//////////////////////////////////////////////////// Get USer part
  Future<List<UserModel>?> getAllUser({
    required void Function(String) onFailure,
  }) async {
    try {
      final snapshot = await collectionReferrenceUser.get();

      return [
        ...snapshot.docs
            .map((e) => UserModel.fromMap(e.data()).copyWith(id: e.id))
      ];
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

  Future<List<UserModel>?> getSubscribedUser({
    required void Function(String) onFailure,
  }) async {
    try {
      final snapshot = await collectionReferrenceUser
          .where('purchaseDetails', isNotEqualTo: []).get();

      return [
        ...snapshot.docs
            .map((e) => UserModel.fromMap(e.data()).copyWith(id: e.id))
      ];
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

  Future<List<UserModel>?> getUnSubscribedUser({
    required void Function(String) onFailure,
  }) async {
    try {
      final snapshot = await collectionReferrenceUser
          .where('purchaseDetails', isEqualTo: []).get();

      return [
        ...snapshot.docs
            .map((e) => UserModel.fromMap(e.data()).copyWith(id: e.id))
      ];
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

  DocumentSnapshot<Map<String, dynamic>>? lastDoc;
  Future<List<UserModel>?> getAllUserLazy(
      {required void Function(String) onFailure,
      required void Function(bool) noMoreData}) async {
    int limit = (lastDoc == null) ? 3 : 1;
    Query query = collectionReferrenceUser;
    try {
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }
      query = query.limit(limit);

      final snapshot = await query.get();
      if (snapshot.docs.length < limit) {
        noMoreData(true);
      } else {
        lastDoc = snapshot.docs.last as DocumentSnapshot<Map<String, dynamic>>;
      }

      return [
        ...snapshot.docs.map((e) =>
            UserModel.fromMap(e.data() as Map<String, dynamic>)
                .copyWith(id: e.id))
      ];
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure("Couldn't able to get the details");
    } catch (e) {
      onFailure("Couldn't able to get the details");
    }
    return null;
  }

  ///////////////////////////////////////////////////////////
  ///
  ///
  /// Notification and payment -----------------------------
  final collectionReferrenceNotification =
      FirebaseFirestore.instance.collection('notification');
  final collectionReferrencePayment =
      FirebaseFirestore.instance.collection('payment_gateway');

  Future<void> addNotification({
    required NotificationModel notification,
    required void Function(String) onSucess,
    required VoidCallback onFailure,
  }) async {
    try {
      await collectionReferrenceNotification.add(notification.toMap());
      onSucess.call('Notification send and saved sucessfully');
    } on FirebaseException catch (e) {
      log(e.code);
      onFailure.call();
    }
  }

////////////////////// Live Zoom Link---------------------
  ///

  final collectionReferenceLive = FirebaseFirestore.instance.collection('live');

  String liveId = 'liveDoc';

//Live set
  Future<void> setLive({
    required ZoomLiveModel liveLink,
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      await collectionReferenceLive.doc(liveId).set(liveLink.toMap());
      onSucess.call('Saved the live link sucessfully');
    } on FirebaseException catch (e) {
      log('live set ${e.code}');
      onFailure.call("Couldn't able to save the link");
    } catch (e) {
      log('Payment set $e');
      onFailure.call("Couldn't able to save the link");
    }
  }

  Future<ZoomLiveModel?> getLive({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    try {
      final liveDetails = await collectionReferenceLive.doc(liveId).get();

      onSucess.call('Got the live link sucessfully');
      return ZoomLiveModel.fromMap(liveDetails.data() ?? <String, dynamic>{});
    } on FirebaseException catch (e) {
      log('live get ${e.toString()}');
      onFailure.call("Couldn't able to get the link");
    } catch (e) {
      log('live get $e');
      onFailure.call("Couldn't able to get the link");
    }
    return null;
  }
}
