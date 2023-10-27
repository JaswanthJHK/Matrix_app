// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class SelectPostImgProvider extends ChangeNotifier {
//   String? returnImagePath;
//   String? postImgUrl;
//   clearImage() {
//     postImgUrl = null;
//     returnImagePath = null;
//     notifyListeners();
//   }

//   postImageClear() {
//     returnImagePath = null;
//     notifyListeners();
//   }

//   addPostProvider(ImageSource imgSource) async {
//     final XFile? returnedImg = await ImagePicker().pickImage(source: imgSource);
//     if (returnedImg?.path != null) {
//       returnImagePath = returnedImg!.path;
//       notifyListeners();
//       String fileName = DateTime.now().microsecondsSinceEpoch.toString();
//       Reference upload =
//           FirebaseStorage.instance.ref().child('post_image').child(fileName);
//       await upload.putFile(File(returnImagePath!));
//       postImgUrl = await upload.getDownloadURL();
//     }
//   }
// }
