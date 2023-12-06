import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/functions/user_data/get_user_data.dart';
import 'package:matrix_app_project/features/data/models/user.dart';

class GetUserDataProvider extends ChangeNotifier {
  Future<User?> getUserDataDetailsProvider(String id) async {
    User? details = await getUserData(id);
    ChangeNotifier();
    return details;
  }
}
