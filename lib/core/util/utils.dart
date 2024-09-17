import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source,BuildContext context) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
  //  final croppedImage = await cropImages(_file);
    return await _file.readAsBytes();
   // Navigator.push(context, MaterialPageRoute(builder: builder))
   
  }
}

showSnackBarMethod(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

// Future<CroppedFile> cropImages(XFile image) async {
//   final croppedFile =
//       await ImageCropper().cropImage(sourcePath: image.path, uiSettings: [
//     AndroidUiSettings(
//         toolbarColor: Colors.deepOrange,
//         toolbarTitle: "Cropper",
//         toolbarWidgetColor: Colors.white,
//         initAspectRatio: CropAspectRatioPreset.original,
//         lockAspectRatio: false,
//         aspectRatioPresets: [
//           CropAspectRatioPreset.square,
//           CropAspectRatioPreset.ratio4x3,
//           CropAspectRatioPreset.original,
//           CropAspectRatioPreset.ratio7x5,
//           CropAspectRatioPreset.ratio16x9,
//         ])
//   ]);
//
//   return croppedFile!;
// }
