import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intermittent_fasting/model/fasting_time.dart';
import 'package:intermittent_fasting/screen/complete_screen.dart';
import 'package:intermittent_fasting/utils/globals.dart';
import 'package:intermittent_fasting/utils/prefs.dart';

class FastingData extends ChangeNotifier {
  Timer? _timer;
  FastingTime _fastingTime = FastingTime();

  FastingTime get fastingTime {
    return _fastingTime;
  }

  Timer? get timer {
    return _timer;
  }

  void settingData() {
    final isFastingTime = prefs.getBool(Prefs().isFastingTime) ?? true;
    setTargetTime(isFastingTime);

    var timerStartTime = prefs.getString(Prefs().timerStartTime) ?? '';
    if (timerStartTime.isNotEmpty) {
      _fastingTime.startTime = DateTime.parse(timerStartTime);
      _fastingTime.elapsedTime =
          DateTime.now().difference(_fastingTime.startTime!).inSeconds;
      _fastingTime.isFasting = isFastingTime;
    } else {
      prefs.setBool(Prefs().isFastingTime, true);
    }
  }

  void setTargetTime(bool isFastingTime) {
    final fastingRatio = prefs.getString(Prefs().fastingTimeRatio) ?? '16:8';
    final hourString = fastingRatio.contains(":")
        ? fastingRatio.split(":").elementAt(isFastingTime ? 0 : 1)
        : fastingRatio;

    _fastingTime.targetTime = Duration(hours: int.parse(hourString)).inSeconds;
  }

  void startTimer() {
    prefs.setString(Prefs().timerStartTime, DateTime.now().toString());
    _fastingTime.startTime ??= DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _fastingTime.elapsedTime++;
    });
  }

  void endTimer() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CompleteScreen(fastingTime: fastingTime))).whenComplete(() {
        fastingTime.elapsedTime = 0;
        fastingTime.isFasting = !fastingTime.isFasting;
        setTargetTime(fastingTime.isFasting);
        startTimer();
      });
    }
  }
}
