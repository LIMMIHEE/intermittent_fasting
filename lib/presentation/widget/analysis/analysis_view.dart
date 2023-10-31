import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/domain/entities/history.dart';
import 'package:intermittent_fasting/presentation/providers/history_provider.dart';
import 'package:intermittent_fasting/presentation/widget/analysis/analysis_fasting_chart.dart';
import 'package:intermittent_fasting/presentation/widget/analysis/analysis_info_row.dart';
import 'package:intermittent_fasting/presentation/widget/analysis/analysis_title_row.dart';
import 'package:intermittent_fasting/presentation/widget/common/no_history_view.dart';
import 'package:provider/provider.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignSystem.colors.backgroundWhite,
      body: SingleChildScrollView(
        child: SafeArea(child: Consumer<HistoryProvider>(builder:
            (BuildContext context, HistoryProvider historyProvider,
                Widget? child) {
          if (historyProvider.list.isEmpty) {
            return const NoHistoryView();
          }

          final historyList = historyProvider.list;
          historyList.sort((a, b) => a.id.compareTo(b.id));

          return Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AnalysisTitleRow(
                  title: '일간 공복시간',
                  subTitle: '일간 / 시간.분',
                ),
                AnalysisFastingChart(historyList: historyList),
                Text(
                  '최근 7가지 기록에 대한 그래프입니다.',
                  style: DesignSystem.typography.body2(TextStyle(
                      color: DesignSystem.colors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  decoration: ShapeDecoration(
                    color: DesignSystem.colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: DesignSystem.colors.divider,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      AnalysisInfoRow(
                        title: '평균 달성률',
                        subTitle: '공복 시간 기준',
                        result: '${fastingTimeAchievement(context)}%',
                        isAchievementInfo: true,
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: DesignSystem.colors.divider,
                      ),
                      AnalysisInfoRow(
                        title: '평균 공복 시간',
                        subTitle: '최신 7가지 기록 기준',
                        result: '${fastingTimeAverage(context).floor()}시간',
                        isAchievementInfo: false,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        })),
      ),
    );
  }

  int fastingTimeAchievement(BuildContext context) {
    final timeAverage = fastingTimeAverage(context);
    final historyList = getHistory(context);
    int fastingTime = 0;

    for (var history in historyList) {
      if (history.fastingRatio.contains('시간')) {
        fastingTime += int.parse(history.fastingRatio.replaceAll('시간', ''));
      } else {
        fastingTime += int.parse(history.fastingRatio.split(":").first);
      }
    }

    return ((timeAverage / (fastingTime / historyList.length)).abs() * 100)
        .round();
  }

  double fastingTimeAverage(BuildContext context) {
    int totalTime = 0;
    final historyList = getHistory(context);
    for (var history in historyList) {
      totalTime += timeDifference(history);
    }

    return ((totalTime / 60) / historyList.length);
  }

  List<History> getHistory(BuildContext context) {
    final historyList = context.read<HistoryProvider>().list;
    historyList.sort((b, a) => a.id.compareTo(b.id));
    final days = historyList.length > 6 ? 6 : historyList.length;
    return historyList.getRange(0, days).toList();
  }

  int timeDifference(History history) {
    final difference = DateTime.parse(history.endDate)
        .difference(DateTime.parse(history.startDate));
    return difference.inMinutes;
  }
}
