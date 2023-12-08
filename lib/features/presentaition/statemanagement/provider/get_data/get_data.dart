// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ProfileDataProvider extends ChangeNotifier {
//   Map<String, dynamic> userData = {};
//   int postLength = 0;
//   int? followers;
//   int? following;
//   bool isLoading = false;
//   bool isFollowing = false;

//   Future<void> getData(String uid) async {
//     followers ??= 0;
//     following ??= 0;
//     isLoading = true;
//     notifyListeners();

//     try {
//       var userSnap = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(uid)
//           .get();

//       // get post length
//       var postSnap = await FirebaseFirestore.instance
//           .collection('posts')
//           .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//           .get();

//       postLength = postSnap.docs.length;
//       userData = userSnap.data()!;
//       followers = userSnap.data()!['followers'].length;
//       following = userSnap.data()!['following'].length;
//       isFollowing = userSnap
//           .data()![followers]
//           .contains(FirebaseAuth.instance.currentUser!.uid);
//     } catch (e) {
//       // Handle errors or show a Snackbar
//     }

//     isLoading = false;
//     notifyListeners();
//   }

//   // Add methods for follow/unfollow and other profile-related functionality
// }
