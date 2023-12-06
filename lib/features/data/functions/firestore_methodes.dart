import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrix_app_project/features/data/functions/storage_methods.dart';
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

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComments(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'timestamp': DateTime.now(),
        });
      } else {}
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  // Future<void> followUser(
  //   String uid,
  //   String followId,
  // ) async {
  //   try {
  //     DocumentSnapshot snap =
  //         await _firestore.collection('users').doc(uid).get();
  //     List following = (snap.data()! as dynamic)['following'];

  //     if (following.contains(followId)) {
  //       await _firestore.collection('users').doc(followId).update({
  //         'followers': FieldValue.arrayRemove([uid])
  //       });

  //       await _firestore.collection('users').doc(uid).update({
  //         'following': FieldValue.arrayRemove([followId])
  //       });
  //     } else {
  //       await _firestore.collection('users').doc(followId).update({
  //         'followers': FieldValue.arrayUnion([uid])
  //       });

  //       await _firestore.collection('users').doc(uid).update({
  //         'following': FieldValue.arrayUnion([followId])
  //       });
  //     }
  //   } catch (e) {}
  // }


  StreamController<List> _followingStreamController = StreamController<List>();

Stream<List> get followingStream => _followingStreamController.stream;

Future<void> followUser(String uid, String followId) async {
  try {
    DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
    List following = (snap.data()! as dynamic)['following'];

    if (following.contains(followId)) {
      await _firestore.collection('users').doc(followId).update({
        'followers': FieldValue.arrayRemove([uid])
      });

      await _firestore.collection('users').doc(uid).update({
        'following': FieldValue.arrayRemove([followId])
      });
    } else {
      await _firestore.collection('users').doc(followId).update({
        'followers': FieldValue.arrayUnion([uid])
      });

      await _firestore.collection('users').doc(uid).update({
        'following': FieldValue.arrayUnion([followId])
      });
    }

    // Fetch and emit the updated 'following' array after the action.
    DocumentSnapshot updatedSnap = await _firestore.collection('users').doc(uid).get();
    List updatedFollowing = (updatedSnap.data()! as dynamic)['following'];
    _followingStreamController.add(updatedFollowing);
  } catch (e) {
    print(e.toString());
  }
}

}
