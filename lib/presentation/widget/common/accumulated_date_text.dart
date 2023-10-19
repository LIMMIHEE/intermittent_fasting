import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/presentation/providers/history_provider.dart';
import 'package:provider/provider.dart';

class AccumulatedDateText extends StatelessWidget {
  const AccumulatedDateText({super.key});

  @override
  Widget build(BuildContext context) {
    final historyList =
        context.select((HistoryProvider history) => history.list);

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 45, bottom: 20),
      child: Text(
        '총 ${historyList.length}일간\n진행 하였습니다.',
        style: DesignSystem.typography.heading2(),
      ),
    );
  }
}
