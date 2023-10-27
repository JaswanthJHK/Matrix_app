// import 'dart:developer';
// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:matrix_app_project/features/data/data_sources/storage_methods.dart';
// import 'package:matrix_app_project/features/data/models/post_model.dart';

// class AddPost extends ChangeNotifier {
//   Future<void> addPost(Uint8List imgUrl, String caption) async {
//     try {
//       CollectionReference postsCollection =
//           FirebaseFirestore.instance.collection('posts');

//       String userId = FirebaseAuth.instance.currentUser!.uid;
//       String time = DateTime.now().toString();
//       String id = DateTime.now().millisecondsSinceEpoch.toString();
//       String photoUlr = await StorageMethods()
//           .uploadImageToStorage('profilePics', imgUrl, false);
//       Map<String, dynamic> postData = {
//         'imgUrl': photoUlr,
//         'caption': caption,
//         'id': userId,
//         'time': time,
//         'postId': id,
//       };

//       await postsCollection
//           .doc(userId)
//           .collection('this_user')
//           .doc(id)
//           .set(postData);

//       caption = '';
//       notifyListeners();
//     } catch (error) {
//       log("Error adding post: $error");
//     }
//   }

//   Future<List<PostModel>> getAllPost() async {
//     List<PostModel> allPost = [];

//     try {
//       QuerySnapshot getusers =
//           await FirebaseFirestore.instance.collection('uids').get();
//       List<DocumentSnapshot> postsin = getusers.docs;

//       for (var i = 0; i < postsin.length; i++) {
//         var data = postsin[i];
//         var uid = data['uid'];
//         var userCollectionSnapshot = await FirebaseFirestore.instance
//             .collection('posts')
//             .doc(uid)
//             .collection('this_user')
//             .get();

//         List<PostModel> posts = userCollectionSnapshot.docs.map((doc) {
//           Map<String, dynamic> data = doc.data();
//           return PostModel.fromJson(data);
//         }).toList();

//         posts.sort((a, b) => b.postId!.compareTo(a.postId!));
//         allPost.addAll(posts);
//         notifyListeners();
//       }
//       allPost.sort((a, b) => b.postId!.compareTo(a.postId!));
//       notifyListeners();

//       return allPost;
//     } catch (e) {
//       print('Error fetching posts: $e');
//       return [];
//     }
//   }
// }
