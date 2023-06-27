import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intermittent_fasting/Screen/FastingRateScreen.dart';
import 'package:intermittent_fasting/Utils/Globals.dart';

import '../Utils/Prefs.dart';
import '../widget/CommonWidget.dart';
import '../widget/HomeWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool fastingState = true;
  Timer? timer;
  int elapsedTime = 0;
  int targetTime = Duration(hours: 16).inSeconds;

  void startTimer() {
    timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => elapsedTime++);
    });
  }

  void endTimer() {
    if (timer != null && timer!.isActive) {
      setState(() {
        timer?.cancel();
        // 단식 완료 화면 혹은 식사 완료 화면으로 이동
      });
    }
  }

  @override
  void initState() {
    targetTime = Duration(hours: prefs.getInt(Prefs().FASTINGTIME)).inSeconds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                top: 0,
                child: ClipPath(
                  clipper: CustomPath(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB82E).withOpacity(0.2),
                    ),
                    width: 300,
                    height: 140,
                  ),
                ),
              ),
              Positioned(
                top: 110,
                child: GestureDetector(
                  onTap: () async {
                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FastingRateScreen(
                                comeStartScreen: false)));

                    if (result != null) {
                      setState(() {
                        targetTime = Duration(hours: result).inSeconds;
                      });
                    }
                  },
                  child: FastingRatioLabel(editIcon: true),
                ),
              ),
              TimerCircleProgress(
                  elapsedTime: elapsedTime, targetTime: targetTime),
            ],
          )),
          ButtonTab(
            timerAction: () {
              if (timer == null || !timer!.isActive) {
                startTimer();
              } else {
                endTimer();
              }
            },
            timerActive: timer?.isActive ?? false,
            widgetChild: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TimerTextContainer(
                      timeText: "6/10 오후 6 : 26",
                      text: "시작시간",
                    ),
                    Image.asset(
                      'assets/images/time_arrow.png',
                      width: 35,
                    ),
                    TimerTextContainer(
                        timeText: "6/10 오후 6 : 26",
                        text: "종료시간",
                        isEdit: false),
                  ],
                ),
              ),
              Divider()
            ],
          )
        ],
      ),
    );
  }
}
