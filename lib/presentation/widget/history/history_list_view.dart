import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/presentation/providers/history_provider.dart';
import 'package:intermittent_fasting/presentation/widget/common/accumulated_date_text.dart';
import 'package:intermittent_fasting/presentation/widget/common/no_history_view.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_bottom_sheet.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_list_item.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_top_label.dart';
import 'package:provider/provider.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (BuildContext context, HistoryProvider historyProvider,
          Widget? child) {
        if (historyProvider.list.isEmpty) {
          return const NoHistoryView();
        }

        final historyList = historyProvider.list;
        historyList.sort((b, a) => a.id.compareTo(b.id));

        return Container(
          color: DesignSystem.colors.backgroundWhite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AccumulatedDateText(historyLength: historyList.length),
                const HistoryTopLabel(),
                historyList.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            "기록이 비어있습니다!",
                            style: DesignSystem.typography.body2(TextStyle(
                                fontWeight: FontWeight.w400,
                                color: DesignSystem.colors.textSecondary)),
                          ),
                        ),
                      )
                    : Flexible(
                        child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: historyList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final history = historyList[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    historyList.length - 1 == index ? 120 : 0),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final TextEditingController controller =
                                        TextEditingController(
                                            text: history.memo);
                                    return HistoryBottomSheet(
                                      history: history,
                                      controller: controller,
                                    );
                                  },
                                );
                              },
                              child: HistoryListItem(history: history),
                            ),
                          );
                        },
                      ))
              ],
            ),
          ),
        );
      },
    );
  }
}
