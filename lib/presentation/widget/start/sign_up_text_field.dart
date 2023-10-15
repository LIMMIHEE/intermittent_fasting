import 'package:flutter/material.dart';

class SignUpTextField extends StatelessWidget {
  const SignUpTextField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.controller});

  final String hintText;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38, vertical: 9),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF392E5C)),
          borderRadius: BorderRadius.circular(49),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF392E5C),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: controller,
                obscureText: hintText == "비밀번호" ? true : false,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Color(0xFF9D9D9D),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
