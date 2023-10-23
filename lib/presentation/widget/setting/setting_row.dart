import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

class SettingRow extends StatelessWidget {
  const SettingRow(
      {super.key,
      required this.title,
      required this.children,
      this.isLast = false});

  final String title;
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
          child: Row(children: [
            Expanded(
              child: Text(
                title,
                style: DesignSystem.typography.body2(TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Config.isLightTheme()
                      ? DesignSystem.colors.textPrimary
                      : DesignSystem.colors.white,
                )),
              ),
            ),
            ...children
          ]),
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
