import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_data.dart';
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
    final fastingTime = context.select((FastingData data) => data.fastingTime);
    final startTime = fastingTime.startTime;
    String timeText = '';

    if (isTimerStart && text == '시작시간') {
      timeText = DateFormat("M/d HH : mm").format(startTime ?? DateTime.now());
    } else if (text != '시작시간') {
      timeText = DateFormat("M/d HH : mm").format(endTimeTargetTime
          ? startTime!.add(Duration(seconds: fastingTime.targetTime))
          : DateTime.now());
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
                  style: const TextStyle(
                    color: Color(0xff392e5c),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
              Visibility(
                visible: isEdit,
                child: GestureDetector(
                  onTap: () {
                    BottomPicker.dateTime(
                      title: '시작 시간을 선택해주세요.',
                      titleStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      initialDateTime: startTime,
                      onSubmit: (date) {
                        context.read<FastingData>().updateStartTime(date);
                        print(date);
                      },
                      iconColor: Colors.black,
                      minDateTime:
                          DateTime.now().subtract(const Duration(days: 5)),
                      maxDateTime: DateTime.now(),
                      buttonSingleColor: const Color(0xFFFFB82E),
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
            style: const TextStyle(
              color: Color(0xff9d9d9d),
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
