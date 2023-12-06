import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrix_app_project/features/data/models/user.dart';

Future<User?> getUserData(String id) async {
  DocumentSnapshot userId =
      await FirebaseFirestore.instance.collection('users').doc(id).get();
  if (userId.exists) {
    User? userDataList = User.fromsnap(userId);
    return userDataList;
  }
  return null;
}
