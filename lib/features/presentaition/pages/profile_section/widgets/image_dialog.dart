import 'package:flutter/material.dart';

class ImageDialog extends StatefulWidget {
  final String imageUrl;
  const ImageDialog({super.key, required this.imageUrl});

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
           
            height: 300,
            width: 300,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              
            ),
          ),
        ),
      ),
    );
  }
}
