import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intermittent_fasting/providers/fasting_history.dart';
import 'package:intermittent_fasting/screen/fasting_rate_screen.dart';
import 'package:intermittent_fasting/utils/globals.dart';
import 'package:intermittent_fasting/screen/complete_screen.dart';
import 'package:provider/provider.dart';

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

  DateTime? startTime;

  void startTimer() {
    prefs.setString(Prefs().timerStartTime, DateTime.now().toString());
    startTime ??= DateTime.now();

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
          setTargetTime(fastingState);
          startTimer();
        });
      });
    }
  }

  void setTargetTime(bool isFastingTime) {
    final fastingRatio = prefs.getString(Prefs().fastingTimeRatio) ?? '16:8';
    final hourString = fastingRatio.contains(":")
        ? fastingRatio.split(":").elementAt(isFastingTime ? 0 : 1)
        : fastingRatio;

    targetTime = Duration(hours: int.parse(hourString)).inSeconds;
  }

  @override
  void initState() {
    final isFastingTime = prefs.getBool(Prefs().isFastingTime) ?? true;
    setTargetTime(isFastingTime);

    var timerStartTime = prefs.getString(Prefs().timerStartTime) ?? '';
    if (timerStartTime.isNotEmpty) {
      startTime = DateTime.parse(timerStartTime);
      elapsedTime = DateTime.now().difference(startTime!).inSeconds;
      fastingState = isFastingTime;

      startTimer();
    } else {
      prefs.setBool(Prefs().isFastingTime, true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => FastingHistory(),
        child: Column(
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
                    child: FastingRatioLabel(
                        editIcon: true, fastingState: fastingState),
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
                    startTime: startTime,
                    endTime: startTime?.add(Duration(seconds: targetTime)),
                    editTime: fastingState ? 'end' : 'start',
                  ),
                ),
                const Divider()
              ],
            )
          ],
        ),
      ),
    );
  }
}
