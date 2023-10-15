import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intermittent_fasting/domain/entities/history.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_history.dart';
import 'package:intermittent_fasting/presentation/widget/common/fasting_ratio_label.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_fasting_time_text.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_time_text.dart';
import 'package:provider/provider.dart';

import 'history_sheet_button.dart';

class HistoryBottomSheet extends StatelessWidget {
  const HistoryBottomSheet({super.key, required this.history});

  final History history;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    '식단 메모',
                    style: TextStyle(
                      color: Color(0xFF392E5C),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  history.memo,
                  style: const TextStyle(
                    color: Color(0xFF392E5C),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              Row(
                children: [
                  FastingRatioLabel(
                    isFastingScreen: false,
                    editIcon: true,
                    ratio: history.fastingRatio,
                  ),
                  Expanded(
                    child: HistoryFastingTimeText(
                      history: history,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    HistoryTimeText(
                      timeText: history.startDate,
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/images/icon_time_arrow.png',
                        width: 35,
                        height: 35,
                      ),
                    ),
                    HistoryTimeText(
                      timeText: history.endDate,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: Platform.isIOS ? 15 : 0,
                ),
                child: Row(
                  children: [
                    HistorySheetButton(
                      onTap: () {
                        context.read<FastingHistory>().deleteHistory(history);
                      },
                      isDeleteButton: true,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    HistorySheetButton(
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
