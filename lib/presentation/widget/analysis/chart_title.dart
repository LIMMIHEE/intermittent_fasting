import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartTitle extends StatelessWidget {
  const ChartTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      space: 16,
      child: Text(title,
          style: const TextStyle(
            color: Color(0xff392e5c),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          )),
    );
  }
}
