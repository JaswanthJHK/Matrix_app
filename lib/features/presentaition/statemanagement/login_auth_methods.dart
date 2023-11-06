
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginAuth extends ChangeNotifier {
  final passwordController = TextEditingController();
  final emailTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
//  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "some error  occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = 'Please enter your credentials';
      }
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
}
