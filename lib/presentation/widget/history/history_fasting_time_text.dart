import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/domain/entities/history.dart';

class HistoryFastingTimeText extends StatelessWidget {
  const HistoryFastingTimeText(
      {super.key, required this.history, this.fontSize = 18});

  final History history;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      fastingTimeText(history),
      textAlign: TextAlign.right,
      style: TextStyle(
        color: DesignSystem.colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  String fastingTimeText(History history) {
    final difference = DateTime.parse(history.endDate)
        .difference(DateTime.parse(history.startDate))
        .toString()
        .split(":");
    return '${difference.first}시간 ${difference.elementAt(1)}분';
  }
}
