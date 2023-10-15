import 'package:flutter/material.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_history.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_bottom_sheet.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_list_item.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_top_label.dart';
import 'package:provider/provider.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyList =
        context.select((FastingHistory history) => history.list);

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 45, bottom: 20),
              child: Text(
                '총 ${historyList.length}일간\n진행 하였습니다.',
                style: const TextStyle(
                  color: Color(0xFF392E5C),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const HistoryTopLabel(),
            historyList.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text("기록이 비어있습니다!"),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: historyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final history = historyList[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: historyList.length - 1 == index ? 120 : 0),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return HistoryBottomSheet(
                                  history: history,
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
  }
}
