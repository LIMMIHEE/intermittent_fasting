import 'package:flutter/material.dart';

class Utils {
  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 2000),
      backgroundColor: const Color(0xFF392E5C),
      content: Text(text),
    ));
  }
}
