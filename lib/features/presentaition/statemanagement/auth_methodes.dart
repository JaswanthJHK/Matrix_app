import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/functions/storage_methods.dart';
import 'package:matrix_app_project/features/data/models/user.dart' as model;
import 'package:matrix_app_project/features/service/notification_service.dart';

class AuthMethods extends ChangeNotifier {
  final signInPasswordController = TextEditingController();
  final signInAboutController = TextEditingController();
  final signInEmailTextController = TextEditingController();
  final signInUserNameTextController = TextEditingController();
  // PUSH NOTIFICATION IS HERE
  static final notification = NotificationService();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    // here was paramter called String userid
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromsnap(snap);
  }

  // sign up user

  Future<String> signUpUser({
    required String username,
    required String about,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (username.isNotEmpty || email.isNotEmpty || password.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photoUlr = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add user to database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          about: about,
         
          photoUrl: photoUlr,
          following: [],
          followers: [],
          lastActive: DateTime.now(),
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "Success";
      }
      // PUSH NOTIFICATION REQPERMISSION AND GET TOKEN --------------

      await notification.requestPermission();
      await notification.getToken();
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        // add here more exceptions
        res = 'The email address is badly formatted';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      }
    } catch (err) {
      res = err.toString();
      print(err.toString());
    }
    return res;
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    signInUserNameTextController.dispose();
    signInPasswordController.dispose();
    signInAboutController.dispose();
    signInEmailTextController.dispose();
  }
}
