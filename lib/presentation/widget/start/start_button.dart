import 'package:flutter/material.dart';

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
