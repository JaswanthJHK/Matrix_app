// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';

// class FollowUserResult {
//   final bool isFollowing;

//   FollowUserResult(this.isFollowing);
// }

// class FollowUserProvider extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   StreamController<FollowUserResult> _followUserController =
//       StreamController<FollowUserResult>.broadcast();

//   Stream<FollowUserResult> get followUserStream =>
//       _followUserController.stream;

//   Future<void> followUser(
//     String uid,
//     String followId,
//   ) async {
//     try {
//       DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
//       List following = (snap.data()! as dynamic)['following'];

//       if (following.contains(followId)) {
//         await _firestore.collection('users').doc(followId).update({
//           'followers': FieldValue.arrayRemove([uid])
//         });

//         await _firestore.collection('users').doc(uid).update({
//           'following': FieldValue.arrayRemove([followId])
//         });

//         _followUserController.add(FollowUserResult(false));
//       } else {
//         await _firestore.collection('users').doc(followId).update({
//           'followers': FieldValue.arrayUnion([uid])
//         });

//         await _firestore.collection('users').doc(uid).update({
//           'following': FieldValue.arrayUnion([followId])
//         });

//         _followUserController.add(FollowUserResult(true));
//       }
//     } catch (e) {
//       _followUserController.addError(e);
//     }
//   }

//   void dispose() {
//     _followUserController.close();
//   }
// }





