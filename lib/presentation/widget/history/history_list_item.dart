import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/domain/entities/history.dart';
import 'package:intermittent_fasting/presentation/widget/common/fasting_ratio_label.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_fasting_time_text.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_time_text.dart';

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({super.key, required this.history});

  final History history;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              FastingRatioLabel(
                  isFastingScreen: false, ratio: history.fastingRatio),
              Expanded(
                child: Column(
                  children: [
                    HistoryTimeText(
                      timeText: history.startDate,
                    ),
                    HistoryTimeText(
                      timeText: history.endDate,
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: HistoryFastingTimeText(
                    history: history,
                    fontSize: 16,
                  )),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: DesignSystem.colors.gray700,
              )
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
