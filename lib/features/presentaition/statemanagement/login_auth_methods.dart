import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/functions/firebase_firestore_service.dart';
import 'package:matrix_app_project/features/service/notification_service.dart';

class LoginAuth extends ChangeNotifier {
  final passwordController = TextEditingController();
  final emailTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
//  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final notification = NotificationService();

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "some error  occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
        emailTextController.clear();
        passwordController.clear();
      } else {
        res = 'Please enter your credentials';
      }
      await FirebaseFirestoreService.updateUserData(
        {'lastActive': DateTime.now()},
      );
      await notification.requestPermission();
      await notification.getToken();
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        // add here more exceptions
        res = 'The email address is badly formatted';
      } else if (err.code == 'INVALID_LOGIN_CREDENTIALS') {
        res = 'Your password is not matching';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailTextController.dispose();
  }
}
