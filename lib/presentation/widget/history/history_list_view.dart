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
    return Consumer<FastingHistory>(
      builder:
          (BuildContext context, FastingHistory fastingHistory, Widget? child) {
        fastingHistory.list.sort((b, a) => a.id.compareTo(b.id));
        return Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 45, bottom: 20),
                  child: Text(
                    '총 ${fastingHistory.list.length}일간\n진행 하였습니다.',
                    style: const TextStyle(
                      color: Color(0xFF392E5C),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const HistoryTopLabel(),
                fastingHistory.list.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text("기록이 비어있습니다!"),
                        ),
                      )
                    : Flexible(
                        child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: fastingHistory.list.length,
                        itemBuilder: (BuildContext context, int index) {
                          final history = fastingHistory.list[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: fastingHistory.list.length - 1 == index
                                    ? 120
                                    : 0),
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
