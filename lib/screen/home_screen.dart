import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intermittent_fasting/screen/fasting_rate_screen.dart';
import 'package:intermittent_fasting/utils/globals.dart';
import 'package:intermittent_fasting/screen/complete_screen.dart';

import '../utils/prefs.dart';
import '../widget/common_widget.dart';
import '../widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool fastingState = true;
  Timer? timer;
  int elapsedTime = 0;
  int targetTime = const Duration(hours: 16).inSeconds;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => elapsedTime++);
    });
  }

  void endTimer() {
    if (timer != null && timer!.isActive) {
      setState(() {
        timer?.cancel();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompleteScreen(
                    progressTime: elapsedTime,
                    isFastingTimeDone: fastingState))).whenComplete(() {
          elapsedTime = 0;
          fastingState = !fastingState;
          startTimer();
        });
      });
    }
  }

  @override
  void initState() {
    targetTime =
        Duration(hours: prefs.getInt(Prefs().fastingTime) ?? 0).inSeconds;
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
                  child: const FastingRatioLabel(editIcon: true),
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
                child: TimerRowContainer(
                  startTime: '',
                  endTime: '',
                  editTime: fastingState ? 'end' : 'start',
                ),
              ),
              const Divider()
            ],
          )
        ],
      ),
    );
  }
}
