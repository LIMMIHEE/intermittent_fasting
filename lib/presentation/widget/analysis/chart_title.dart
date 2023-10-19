import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

class ChartTitle extends StatelessWidget {
  const ChartTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      space: 16,
      child: Text(title,
          style: DesignSystem.typography
              .title3(const TextStyle(fontWeight: FontWeight.w700))),
    );
  }
}
