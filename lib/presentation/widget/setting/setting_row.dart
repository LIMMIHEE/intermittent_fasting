import 'package:flutter/material.dart';

class SettingRow extends StatelessWidget {
  const SettingRow({super.key, required this.children, this.isLast = false});

  final List<Widget> children;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 25),
          child: Row(children: children),
        ),
        Visibility(
          visible: isLast,
          child: const Divider(
            height: 1,
          ),
        ),
      ],
    );
  }
}
