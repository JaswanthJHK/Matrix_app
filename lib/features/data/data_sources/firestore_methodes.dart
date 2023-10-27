import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrix_app_project/features/data/data_sources/storage_methods.dart';
import 'package:matrix_app_project/features/data/models/post_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethodes {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // post upload
  Future<String> postUpload(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImge,
  ) async {
    String res = "some Error occured";
    try {
      // here the upload image for creating a child foleder for uploading img in firestore and to get url
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid()
          .v1(); // v1 will give unique id based on the time, every time

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImge,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Deleting the post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      // print(e.toString());
    }
  }
}
