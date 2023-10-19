import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimerTextContainer extends StatelessWidget {
  const TimerTextContainer(
      {super.key,
      required this.text,
      required this.isTimerStart,
      this.isEdit = false,
      this.endTimeTargetTime = false});

  final String text;
  final bool isEdit;
  final bool isTimerStart;
  final bool endTimeTargetTime;

  @override
  Widget build(BuildContext context) {
    final fastingTime =
        context.select((FastingProvider data) => data.fastingTime);
    final startTime = fastingTime.startTime;
    String timeText = '';

    if (isTimerStart && text == '시작시간') {
      timeText = DateFormat("M/d HH : mm").format(startTime ?? DateTime.now());
    } else if (text != '시작시간') {
      if (startTime != null) {
        timeText = DateFormat("M/d HH : mm").format(endTimeTargetTime
            ? startTime.add(Duration(seconds: fastingTime.targetTime))
            : DateTime.now());
      }
    }

    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,
                  textAlign: TextAlign.center,
                  style: DesignSystem.typography.heading4()),
              Visibility(
                visible: isEdit,
                child: GestureDetector(
                  onTap: () {
                    BottomPicker.dateTime(
                      title: '시작 시간을 선택해주세요.',
                      titleStyle: DesignSystem.typography.heading4(TextStyle(
                        fontWeight: FontWeight.w700,
                        color: DesignSystem.colors.black,
                      )),
                      initialDateTime: startTime,
                      onSubmit: (date) {
                        context.read<FastingProvider>().updateStartTime(date);
                      },
                      iconColor: DesignSystem.colors.black,
                      minDateTime:
                          DateTime.now().subtract(const Duration(days: 5)),
                      maxDateTime: DateTime.now(),
                      buttonSingleColor: DesignSystem.colors.appPrimary,
                    ).show(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.edit,
                      size: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            timeText,
            style: DesignSystem.typography.title2(TextStyle(
                color: DesignSystem.colors.gray700,
                fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}
