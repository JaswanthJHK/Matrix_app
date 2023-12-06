import 'package:flutter/material.dart';

warning(BuildContext context, String warning) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(warning),
  ));
}