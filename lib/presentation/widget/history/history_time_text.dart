import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intl/intl.dart';

class HistoryTimeText extends StatelessWidget {
  const HistoryTimeText(
      {super.key, required this.timeText, this.fontSize = 16});

  final String timeText;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      dateFormatText(timeText),
      style: TextStyle(
        color: DesignSystem.colors.gray700,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  String dateFormatText(String date) {
    return DateFormat("M/d HH : mm").format(DateTime.parse(date));
  }
}
