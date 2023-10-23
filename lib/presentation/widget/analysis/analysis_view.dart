import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/presentation/providers/history_provider.dart';
import 'package:intermittent_fasting/presentation/widget/analysis/analysis_fasting_chart.dart';
import 'package:intermittent_fasting/presentation/widget/common/no_history_view.dart';
import 'package:provider/provider.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignSystem.colors.backgroundWhite,
      body: SafeArea(child: Consumer<HistoryProvider>(builder:
          (BuildContext context, HistoryProvider historyProvider,
              Widget? child) {
        if (historyProvider.list.isEmpty) {
          return const NoHistoryView();
        }

        final historyList = historyProvider.list;
        historyList.sort((a, b) => a.id.compareTo(b.id));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, bottom: 48),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '일간 공복시간',
                      style: DesignSystem.typography.heading3(TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Config.isLightTheme()
                            ? DesignSystem.colors.textPrimary
                            : DesignSystem.colors.white,
                      )),
                    ),
                    Text(
                      '  일간 / 시간.분',
                      style: DesignSystem.typography.body2(TextStyle(
                          color: DesignSystem.colors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                    )
                  ],
                )),
            AnalysisFastingChart(historyList: historyList),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                '최근 7가지 기록에 대한 그래프입니다.',
                style: DesignSystem.typography.body2(TextStyle(
                    color: DesignSystem.colors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400)),
              ),
            )
          ],
        );
      })),
    );
  }
}
