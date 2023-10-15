import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/utils/time_utils.dart';
import 'package:intermittent_fasting/domain/entities/fasting_time.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_data.dart';
import 'package:provider/provider.dart';

class HomeTimerCircleProgress extends StatefulWidget {
  const HomeTimerCircleProgress({super.key});

  @override
  State<HomeTimerCircleProgress> createState() =>
      _HomeTimerCircleProgressState();
}

class _HomeTimerCircleProgressState extends State<HomeTimerCircleProgress> {
  late FastingTime fastingTime;
  Timer? timer;

  bool fastingTimeSetting = false;

  int elapsedTime = 0;
  int targetTime = 1;

  @override
  Widget build(BuildContext context) {
    fastingTime = context.select((FastingData data) => data.fastingTime);
    if (!fastingTimeSetting) {
      fastingTimeSetting = true;
      setFastingTime();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: CircularProgressIndicator(
                  value: elapsedTime / targetTime,
                  color: const Color(0xffFFB82E),
                  backgroundColor: const Color(0xffF2F2F2),
                  strokeWidth: 20)),
        ),
        SizedBox(
            width: 280,
            height: 280,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(200),
              ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(" "),
            Text(
              TimeUtils().printDuration(Duration(seconds: elapsedTime)),
              style: const TextStyle(
                color: Color(0xff392e5c),
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text("현재 진행 시간",
                style: TextStyle(
                  color: Color(0xff9d9d9d),
                  fontSize: 12,
                )),
          ],
        )
      ],
    );
  }

  void setFastingTime() {
    if (fastingTime.startTime != null) {
      targetTime = fastingTime.targetTime;
      elapsedTime = DateTime.now().difference(fastingTime.startTime!).inSeconds;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) {
          setState(() {
            elapsedTime++;
          });
        }
      });
    }
  }
}
