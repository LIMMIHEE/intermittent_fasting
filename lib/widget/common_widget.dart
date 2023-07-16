import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:intermittent_fasting/providers/fasting_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ButtonTab extends StatelessWidget {
  const ButtonTab({super.key, required this.widgetChild});

  final List<Widget> widgetChild;

  @override
  Widget build(BuildContext context) {
    final fastingTime = context.read<FastingData>().fastingTime;
    final isTimerActive = context.read<FastingData>().isTimerActive;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 19),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              ...widgetChild,
              Padding(
                padding: EdgeInsets.only(top: widgetChild.isNotEmpty ? 15 : 0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonTabItem(
                      icon: Icons.timer,
                      title: "단식",
                    ),
                    ButtonTabItem(
                      icon: Icons.sticky_note_2,
                      title: "기록",
                    ),
                    ButtonTabItem(
                      icon: Icons.insert_chart_rounded,
                      title: "분석",
                    ),
                    ButtonTabItem(
                      icon: Icons.settings,
                      title: "설정",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 186,
          child: GestureDetector(
            onTap: () {
              if (!isTimerActive) {
                context.read<FastingData>().startTimeSet();
              } else {
                context.read<FastingData>().endTimeSet(context);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                width: 110,
                height: 45,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xffFFB82E),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffFFB82E).withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      fastingTime.startTime == null ? "시작" : "종료",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Icon(
                        fastingTime.startTime == null
                            ? Icons.play_arrow_rounded
                            : Icons.pause,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonTabItem extends StatelessWidget {
  const ButtonTabItem({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(title),
        )
      ],
    );
  }
}

class FastingRatioLabel extends StatelessWidget {
  const FastingRatioLabel({super.key, this.editIcon = false});

  final bool editIcon;

  @override
  Widget build(BuildContext context) {
    final fastingTime = context.select((FastingData data) => data.fastingTime);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffffb72d),
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${fastingTime.fastingRatio} ${fastingTime.isFasting ? '단식중' : '식사중'}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xffffb72d),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Visibility(
            visible: editIcon,
            child: const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(
                Icons.edit,
                color: Color(0xffffb72d),
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TimerRowContainer extends StatelessWidget {
  const TimerRowContainer({
    super.key,
    this.isHomeScreen = false
  });

  final bool isHomeScreen;

  @override
  Widget build(BuildContext context) {
    final isTimerActive = context.read<FastingData>().isTimerActive;

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
        TimerTextContainer(text: "종료시간",
            endTimeTargetTime:isHomeScreen,
            isTimerStart: isTimerActive
        ),
      ],
    );
  }
}

class TimerTextContainer extends StatelessWidget {
  const TimerTextContainer(
      {super.key,
      required this.text,
      required this.isTimerStart,
      this.isEdit = false,
        this.endTimeTargetTime=false});

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
      timeText = DateFormat("M/d HH : mm")
          .format(startTime ?? DateTime.now());
    } else if (text != '시작시간') {
      timeText = DateFormat("M/d HH : mm").format(
          endTimeTargetTime ? startTime!.add(Duration(seconds: fastingTime.targetTime)): DateTime.now());
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
