import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/functions/storage_methods.dart';

class EditProfileProvider extends ChangeNotifier {
  editProfile(String name, String about, Uint8List file) {
    editProfileProvider(name, about, file);
    notifyListeners();
  }
}

editProfileProvider(String name, String about, Uint8List file) async {
  String photoUlr =
      await StorageMethods().uploadImageToStorage('profilePics', file, false);

  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({"username": name, "about": about, "photoUrl": photoUlr});
}
