import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/functions/storage_methods.dart';

class EditProfileProvider extends ChangeNotifier {
  editProfile(
    String name,
    String about,
    Uint8List file,
  ) {
    editProfileProvider(name, about, file);
    notifyListeners();
  }
}

String currentUserId = FirebaseAuth.instance.currentUser!.uid;

editProfileProvider(String name, String about, Uint8List file) async {
  String photoUlr =
      await StorageMethods().uploadImageToStorage('profilePics', file, false);

  FirebaseFirestore.instance.collection("users").doc(currentUserId).update({
    "username": name,
    "about": about,
    "photoUrl": photoUlr,
  });

  // update username in posts feed screen

  QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
      .collection('posts')
      .where("uid", isEqualTo: currentUserId)
      .get();

  for (QueryDocumentSnapshot postDoc in postsSnapshot.docs) {
    await postDoc.reference.update({"username": name,
    "profImage":photoUlr
    });
  }
}
