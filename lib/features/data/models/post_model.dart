
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
 final String uid;
  final String description;
  final String username;
  final String postId;
  final  datePublished;
  final String postUrl;
  final String profImage;
  final likes;

 const Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      required this.likes
      });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid":uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes,
        "postUrl": postUrl
      };

  static Post fromsnap(DocumentSnapshot snap) {
    var snaphsot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snaphsot['username'],
      uid: snaphsot['uid'],
      description: snaphsot['description'],
      postId: snaphsot['postId'],
      datePublished: snaphsot['datePublished'],
      profImage: snaphsot['profImage'],
      likes: snaphsot['likes'],
      postUrl: snaphsot['postUrl']
    );
  }
}















  