import 'dart:developer';

import 'package:chahel_web_1/src/features/users/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRepo {
  static DocumentSnapshot<Map<String, dynamic>>? lastDoc;
  static bool noMoreData = false;

  //FETCH ALL USERS
  static Future<List<UserModel>> fetchAllUsers(
      {required String? search, required int tabIndex}) async {
    if (noMoreData) return [];
    log('fetch all user called');
    try {
      Query query = FirebaseFirestore.instance
          .collection('users')
          .orderBy('createdAt', descending: true);

      if (tabIndex == 1) {
        query = query.where('purchaseDetails', isNotEqualTo: []);
      } else if (tabIndex == 2) {
        query = query.where('purchaseDetails', isEqualTo: []);
      }
      if (search != null && search.isNotEmpty) {
        query = query.where('keywords', arrayContains: search.toLowerCase());
      }
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
        log(lastDoc.toString());
      }
      final snapshots = await query.limit(5).get();
      log("SNAPSHOTS${snapshots.docs.length}");

      if (snapshots.docs.length < 5 || snapshots.docs.isEmpty) {
        log('No more data called');
        noMoreData = true;
      } else {
        lastDoc = snapshots.docs.last as DocumentSnapshot<Map<String, dynamic>>;
      }
      final usersList = snapshots.docs
          .map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      log(usersList.length.toString());
      return usersList;
    } catch (err) {
      print("ERROR IN USERS FETCHING:$err");
      return [];
    }
  }

  //CLEAR USERS DATA
  static void clearData() {
    noMoreData = false;
    lastDoc = null;
  }
}
