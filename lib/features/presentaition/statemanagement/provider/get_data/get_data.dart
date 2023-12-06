import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matrix_app_project/core/util/utils.dart';

class ProfileProvider with ChangeNotifier {
  Map<String, dynamic> userData = {};
  int postLength = 0;
  int? followers;
  int? following;
  bool isLoading = false;
  bool isFollowing = false;

  Future<void> getData(String uid, BuildContext context) async {
    followers ??= 0;
    following ??= 0;
    isLoading = true;
    notifyListeners(); // Notify listeners about the loading state change

    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLength = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followes'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap.data()![followers].contains(FirebaseAuth.instance.currentUser!.uid);

      notifyListeners(); // Notify listeners about the data changes
    } catch (e) {
      showSnackBarMethod(e.toString(), context);
    }

    isLoading = false;
    notifyListeners(); // Notify listeners about the loading state change
  }
}
