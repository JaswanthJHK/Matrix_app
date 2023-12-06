
// CHAT USER MODEL -------------

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String photUrl;
  final DateTime lastActive;
  final bool isOnline;

  const UserModel({
    required this.username,
    required this.photUrl,
    required this.lastActive,
    required this.uid,
    required this.email,
    this.isOnline = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        uid: json['uid'],
        username: json['username'],
        photUrl: json['photoUrl'],
        email: json['email'],
        isOnline: json['isOnline'] ?? false,
        lastActive: json['lastActive'].toDate(),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'photoUrl': photUrl,
        'email': email,
        'isOnline': isOnline,
        'lastActive': lastActive,
      };
}
