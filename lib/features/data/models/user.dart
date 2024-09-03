import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String about;
  final List followers;
  final List following;
  final DateTime lastActive;
 
  final bool isOnline;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.about,
    required this.followers,
    required this.following,
    required this.lastActive,
   
    this.isOnline = false,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "about": about,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "followers": followers,
        "following": following,
        "lastActive": lastActive,
      
        "isOnline": isOnline,
      };

  static User fromsnap(DocumentSnapshot snap) {
    var snaphsot = snap.data() as Map<String, dynamic>;

    return User(
      email: snaphsot['email'],
      uid: snaphsot['uid'],
      photoUrl: snaphsot['photoUrl'],
      username: snaphsot['username'],
      about: snaphsot['about'],
      followers: snaphsot['followers'],
      following: snaphsot['following'],
      lastActive: (snaphsot['lastActive'] as Timestamp).toDate(),
     
      isOnline: snaphsot['isOnline'] ?? false,
    );
  }
}
