import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginAuth extends ChangeNotifier{

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
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}