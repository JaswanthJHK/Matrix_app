import 'package:flutter/material.dart';

class Skelton extends StatelessWidget {
  final double? height, width;
  const Skelton({super.key,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsetsDirectional.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16)
      ),


    );
  }
}
