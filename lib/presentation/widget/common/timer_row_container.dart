import 'package:flutter/material.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:intermittent_fasting/presentation/widget/common/timer_text_container.dart';
import 'package:provider/provider.dart';

class TimerRowContainer extends StatelessWidget {
  const TimerRowContainer({super.key, this.isHomeScreen = false});

  final bool isHomeScreen;

  @override
  Widget build(BuildContext context) {
    final isTimerActive =
        context.select((FastingProvider provider) => provider.isTimerActive);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TimerTextContainer(
            text: "시작시간", isTimerStart: isTimerActive, isEdit: isTimerActive),
        Visibility(
          visible: isTimerActive,
          child: Image.asset(
            'assets/images/icon_time_arrow.png',
            width: 35,
          ),
        ),
        TimerTextContainer(
            text: "종료시간",
            endTimeTargetTime: isHomeScreen,
            isTimerStart: isTimerActive),
      ],
    );
  }
}
