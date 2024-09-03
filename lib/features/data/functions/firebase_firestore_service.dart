import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matrix_app_project/features/data/functions/firebase_storage_service.dart';
import 'package:matrix_app_project/features/data/models/message_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:matrix_app_project/features/data/models/user.dart' as model;

class FirebaseFirestoreService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> createUser(
      {required String username,
      required String photoUrl,
      required String email,
      required String uid,
      required String about}) async {
    final user = model.User(
      uid: uid,
      email: email,
      username: username,
      photoUrl: photoUrl,
      about: about,
      isOnline: true,
      lastActive: DateTime.now(),
      
      followers: [],
      following: [],
    );

    await _firestore.collection('users').doc(uid).set(user.toJson());
  }

  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
  }) async {
    final message = Message(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> addImageMessage({
    required String receiverId,
    required Uint8List file,
  }) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');

    final message = Message(
      content: image,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.image,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> _addMessageToChat(
    String receiverId,
    Message message,
  ) async {
    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await _firestore
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(message.toJson());
  }

  static Future<void> updateUserData(Map<String, dynamic> data) async =>
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);

// user Report Function

   Future<void> reportUser(String reportUserId, String postId) async {
    final report = {
      'reportedBy': FirebaseAuth.instance.currentUser!.uid,
      'postId': postId,
      'postOwnerId': reportUserId,
      'timeStampp': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('Report').add(report);
  }
}
