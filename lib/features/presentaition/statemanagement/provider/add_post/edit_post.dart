import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPostProvider extends ChangeNotifier {
  editPost(String postId, String newDescription) async {
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .update({"description": newDescription});
    } catch (e) {
      log("error ${e.toString()}");
    }
  }
}
