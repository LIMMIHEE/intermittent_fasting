import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/domain/entities/history.dart';
import 'package:intermittent_fasting/presentation/providers/history_provider.dart';
import 'package:intermittent_fasting/presentation/widget/analysis/chart_title.dart';
import 'package:intermittent_fasting/presentation/widget/common/no_history_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AnalysisFastingChart extends StatelessWidget {
  const AnalysisFastingChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(builder:
        (BuildContext context, HistoryProvider fastingHistory, Widget? child) {
      if (fastingHistory.list.isEmpty) {
        return const NoHistoryView();
      }

      return AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
          child: BarChart(
            BarChartData(
              barTouchData: barTouchData,
              titlesData: titlesData(fastingHistory.list),
              borderData: borderData,
              barGroups: barGroups(fastingHistory.list.length > 6
                  ? fastingHistory.list.sublist(0, 7)
                  : fastingHistory.list),
              gridData: const FlGridData(show: false),
              alignment: BarChartAlignment.spaceAround,
            ),
          ),
        ),
      );
    });
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.toString(),
              DesignSystem.typography
                  .title1(const TextStyle(fontWeight: FontWeight.w700)),
            );
          },
        ),
      );

  FlTitlesData titlesData(List<History> list) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, _) {
              final startDay = list.elementAt(value.toInt()).startDate;
              return ChartTitle(
                title: DateFormat("M/d").format(DateTime.parse(startDay)),
              );
            },
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> barGroups(List<History> list) =>
      List.generate(list.length, (i) {
        final history = list[i];
        final fastingTime = DateTime.parse(history.endDate)
            .difference(DateTime.parse(history.startDate));

        String twoDigits(int n) => n.toString().padLeft(2, "0");
        String minutes = twoDigits(fastingTime.inHours.remainder(60).abs());
        String seconds = twoDigits(fastingTime.inMinutes.remainder(60).abs());

        final parseTime = double.parse('$minutes.$seconds');

        return BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: parseTime,
              color: DesignSystem.colors.appPrimary,
            )
          ],
          showingTooltipIndicators: [0],
        );
      });
}
