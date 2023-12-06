import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';

class chatCustomTextFormField extends StatelessWidget {
  const chatCustomTextFormField({
    super.key,
    required this.chatController,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.obscureText,
    this.onpressedSuffixIcon,
    this.onchanged,
  });

  final TextEditingController chatController;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final VoidCallback? onpressedSuffixIcon;
  final ValueChanged<String>? onchanged;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: chatController,
        obscureText: obscureText ?? false,
        onChanged: onchanged,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ?Icon(prefixIcon) :null,
          suffixIcon: suffixIcon != null?IconButton(onPressed: onpressedSuffixIcon, icon: Icon(suffixIcon),):null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: greyLite)
          )
        ),
      );
}
