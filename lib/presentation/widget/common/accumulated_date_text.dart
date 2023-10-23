import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

class AccumulatedDateText extends StatelessWidget {
  const AccumulatedDateText({super.key, required this.historyLength});

  final int historyLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 45, bottom: 20),
      child: Text(
        '총 $historyLength일간\n진행 하였습니다.',
        style: DesignSystem.typography.heading2(TextStyle(
          fontWeight: FontWeight.w700,
          color: Config.isLightTheme()
              ? DesignSystem.colors.textPrimary
              : DesignSystem.colors.white,
        )),
      ),
    );
  }
}
