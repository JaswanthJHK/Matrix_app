// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class CommentLengthProvider extends ChangeNotifier {
//   var commentLength = 0;

//   Future<void> getCommentLen(String postId) async {
//     try {
//       QuerySnapshot snap = await FirebaseFirestore.instance
//           .collection('posts')
//           .doc(postId)
//           .collection('comments')
//           .get();

//       commentLength = snap.docs.length ;
//     } catch (e) {
//       // Handle the error as needed
//       print(e.toString());
//     }
//     notifyListeners();
//   }
// }
