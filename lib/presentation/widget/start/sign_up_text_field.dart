import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

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
          side: BorderSide(width: 1, color: DesignSystem.colors.appSecondary),
          borderRadius: BorderRadius.circular(49),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: DesignSystem.colors.appSecondary,
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
                  hintStyle: DesignSystem.typography.body2(TextStyle(
                    color: DesignSystem.colors.gray700,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
