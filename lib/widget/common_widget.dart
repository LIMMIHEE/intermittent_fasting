import 'package:flutter/material.dart';

import '../utils/globals.dart';
import '../utils/prefs.dart';

class ButtonTab extends StatelessWidget {
  const ButtonTab(
      {super.key,
      required this.timerAction,
      required this.widgetChild,
      required this.timerActive});

  final bool timerActive;
  final Function() timerAction;
  final List<Widget> widgetChild;

  @override
  Widget build(BuildContext context) {
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
            onTap: () => timerAction(),
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
                      timerActive ? "종료" : "시작",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Icon(
                        timerActive ? Icons.pause : Icons.play_arrow_rounded,
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
    return Container(
      width: editIcon ? 90 : 70,
      padding: const EdgeInsets.symmetric(vertical: 6),
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
            prefs.getString(Prefs().fastingTimeRatio) ?? '',
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
    required this.startTime,
    required this.endTime,
    required this.editTime,
  });

  final String startTime;
  final String endTime;
  final String editTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TimerTextContainer(
            timeText: "6/10 오후 6 : 26",
            text: "시작시간",
            isEdit: editTime == "start"),
        Image.asset(
          'assets/images/icon_time_arrow.png',
          width: 35,
        ),
        TimerTextContainer(
            timeText: "6/10 오후 6 : 26",
            text: "종료시간",
            isEdit: editTime == "end"),
      ],
    );
  }
}

class TimerTextContainer extends StatelessWidget {
  const TimerTextContainer(
      {super.key,
      required this.text,
      required this.timeText,
      this.isEdit = true});

  final String text;
  final String timeText;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  onTap: () {},
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
