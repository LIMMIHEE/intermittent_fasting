import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/core/utils/utils.dart';
import 'package:intermittent_fasting/domain/entities/history.dart';
import 'package:intermittent_fasting/presentation/providers/history_provider.dart';
import 'package:intermittent_fasting/presentation/widget/common/fasting_ratio_label.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_fasting_time_text.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_time_text.dart';
import 'package:provider/provider.dart';

import 'history_sheet_button.dart';

class HistoryBottomSheet extends StatelessWidget {
  const HistoryBottomSheet({
    super.key,
    required this.history,
    required this.controller,
  });

  final History history;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignSystem.colors.backgroundWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Text(
                      '식단 메모',
                      style: DesignSystem.typography.heading3(),
                    ),
                  ),
                  TextField(
                    maxLines: 9,
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: controller.text.isEmpty ? '기록이 비어있습니다!' : null,
                      hintStyle: DesignSystem.typography.body2(TextStyle(
                          fontWeight: FontWeight.w400,
                          color: DesignSystem.colors.textSecondary)),
                      labelStyle: DesignSystem.typography.title3(),
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
                          Utils.showDeleteDialog(
                              context,
                              () => () {
                                    context
                                        .read<HistoryProvider>()
                                        .deleteHistory(history);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                        },
                        isDeleteButton: true,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      HistorySheetButton(
                        onTap: () {
                          context
                              .read<HistoryProvider>()
                              .updateHistoryMemo(history.id, controller.text);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
