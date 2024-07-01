// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class EditProfileProvider extends ChangeNotifier {
//   editProfile(String uid, String newAbout) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(uid)
//           .update({"about": newAbout});
//     } catch (e) {
//       log("error ${e.toString()}");
//     }
//   }
// }
