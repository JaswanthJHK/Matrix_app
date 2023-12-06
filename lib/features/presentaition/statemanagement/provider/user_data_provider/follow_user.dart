import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/functions/firestore_methodes.dart';
import 'package:matrix_app_project/features/data/functions/user_data/get_user_data.dart';
import 'package:matrix_app_project/features/data/models/user.dart' as model;

class UserDataProvider extends ChangeNotifier {
  followUsers({required String uid, required String followId}) async {
    await FirestoreMethodes().followUser(uid, followId);
    ChangeNotifier();
    notifyListeners();
  }

  Future<model.User?> getUserDataProvider(String id) async {
    model.User? userdata = await getUserData(id);
    return userdata;
  }
}
