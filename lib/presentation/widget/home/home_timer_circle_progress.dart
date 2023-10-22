import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/core/utils/time_utils.dart';
import 'package:intermittent_fasting/domain/entities/fasting_time.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:provider/provider.dart';

class HomeTimerCircleProgress extends StatefulWidget {
  const HomeTimerCircleProgress({super.key});

  @override
  State<HomeTimerCircleProgress> createState() =>
      _HomeTimerCircleProgressState();
}

class _HomeTimerCircleProgressState extends State<HomeTimerCircleProgress> {
  Timer? timer;
  int currentHashCode = 0;

  int elapsedTime = 0;
  int targetTime = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FastingProvider>(builder:
        (BuildContext context, FastingProvider fastingProvider, Widget? child) {
      if (currentHashCode != fastingProvider.fastingTime.hashCode) {
        setFastingTime(fastingProvider.fastingTime);
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
                      color: DesignSystem.colors.black.withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: CircularProgressIndicator(
                    value: elapsedTime / targetTime,
                    color: DesignSystem.colors.appPrimary,
                    backgroundColor: DesignSystem.colors.backgroundDisabled,
                    strokeWidth: 20)),
          ),
          SizedBox(
              width: 280,
              height: 280,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignSystem.colors.white,
                  borderRadius: BorderRadius.circular(200),
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(" "),
              Text(
                TimeUtils().printDuration(Duration(seconds: elapsedTime)),
                style: DesignSystem.typography.display1(),
              ),
              Text("현재 진행 시간",
                  style: DesignSystem.typography.caption1(TextStyle(
                      color: DesignSystem.colors.gray700,
                      fontWeight: FontWeight.w400))),
            ],
          )
        ],
      );
    });
  }

  void setFastingTime(FastingTime fastingTime) {
    currentHashCode = fastingTime.hashCode;
    if (fastingTime.startTime != null) {
      timer?.cancel();
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
