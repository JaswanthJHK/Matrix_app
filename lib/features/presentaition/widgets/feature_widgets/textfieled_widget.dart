import 'package:flutter/material.dart';

class MyTextfieled extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isPasswordType;
  final IconData icon;

  const MyTextfieled({
    super.key,
    required this.controller,
    required this.hintText,
     this.isPasswordType =false,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordType,
        //enableSuggestions: !isPasswordType,
        //asautocorrect: !isPasswordType,
        decoration: InputDecoration(
          prefixIcon:Icon(icon,color: Colors.grey,),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}
