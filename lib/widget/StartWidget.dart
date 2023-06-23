import 'package:flutter/material.dart';

class SignUpTextField extends StatelessWidget {
  const SignUpTextField(
      {super.key, required this.hintText, required this.icon});

  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38, vertical: 9),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF392E5C)),
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
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: Color(0xFF9D9D9D),
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton(
      {super.key,
      required this.childWidget,
      required this.onTap,
      this.isOutlineWidget = false});

  final Widget childWidget;
  final Function onTap;
  final bool isOutlineWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          height: 72,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 39),
          decoration: ShapeDecoration(
              color: isOutlineWidget ? Colors.white : const Color(0xFF392E5C),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: isOutlineWidget ? 1 : 0,
                    color: const Color(0xFF392E5C)),
                borderRadius: BorderRadius.circular(49),
              )),
          child: childWidget),
    );
  }
}
