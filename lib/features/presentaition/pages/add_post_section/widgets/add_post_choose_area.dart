import 'dart:typed_data';

import 'package:flutter/material.dart';

class AddPostScreeShowImage extends StatelessWidget {
  const AddPostScreeShowImage({
    super.key,
    required MediaQueryData mediaquery,
  }) : _mediaquery = mediaquery;

  final MediaQueryData _mediaquery;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _mediaquery.size.width * 0.87,
      height: _mediaquery.size.height * 0.4,
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: NetworkImage(
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
              fit: BoxFit.fill),
          border: Border.all(color: Colors.grey, width: 2.0),
          color: const Color.fromARGB(255, 164, 164, 164),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Add Image here",
            style: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class AddPostScreenImageUpload extends StatelessWidget {
  const AddPostScreenImageUpload({
    super.key,
    required MediaQueryData mediaquery,
    required Uint8List? file,
  })  : _mediaquery = mediaquery,
        _file = file;

  final MediaQueryData _mediaquery;
  final Uint8List? _file;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _mediaquery.size.width * 0.87,
      height: _mediaquery.size.height * 0.4,
      decoration: BoxDecoration(
          image: DecorationImage(image: MemoryImage(_file!), fit: BoxFit.cover),
          border: Border.all(color: Colors.grey, width: 2.0),
          color: const Color.fromARGB(255, 164, 164, 164),
          borderRadius: BorderRadius.circular(8)),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Text(
      //       "Add Image",
      //       style: TextStyle(
      //           color: Colors.grey[500],
      //           fontSize: 18,
      //           fontWeight: FontWeight.bold),
      //     )
      //   ],
      // ),
    );
  }
}
