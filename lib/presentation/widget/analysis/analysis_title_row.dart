import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

class AnalysisTitleRow extends StatelessWidget {
  const AnalysisTitleRow({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 48),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: DesignSystem.typography.heading3(TextStyle(
                fontWeight: FontWeight.w700,
                color: Config.isLightTheme()
                    ? DesignSystem.colors.textPrimary
                    : DesignSystem.colors.white,
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                subTitle,
                style: DesignSystem.typography.body2(TextStyle(
                    color: DesignSystem.colors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
              ),
            )
          ],
        ));
  }
}
