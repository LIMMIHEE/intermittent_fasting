import 'package:flutter/material.dart';

class ButtonTabItem extends StatelessWidget {
  const ButtonTabItem({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(title),
        )
      ],
    );
  }
}
