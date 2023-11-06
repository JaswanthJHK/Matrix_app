import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/models/user.dart';

class SearchProvider extends ChangeNotifier {
  List<User> searchedList = [];
  List<User> allUser = [];
  TextEditingController searchController = TextEditingController();

  getAllUser() async {
    QuerySnapshot allUserCollection =
        await FirebaseFirestore.instance.collection('users').get();
    List<DocumentSnapshot> userDocument = allUserCollection.docs;
    for (var docSnapshot in userDocument) {
      allUser.add(User.fromsnap(docSnapshot));
    }
  }

  List<User> getSearchedList(String query) {
   // getAllUser();
    log(".................................$allUser");
    searchedList.clear();
    searchedList = allUser
        .where((element) =>
            element.username.toLowerCase().contains(query.toLowerCase().trim()))
        .toList();
    notifyListeners();
    return searchedList;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
