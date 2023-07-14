import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intermittent_fasting/model/fasting_time.dart';
import 'package:intermittent_fasting/screen/complete_screen.dart';
import 'package:intermittent_fasting/utils/globals.dart';
import 'package:intermittent_fasting/utils/prefs.dart';

class FastingData extends ChangeNotifier {
  static Timer? _timer;
  static FastingTime _fastingTime = FastingTime();

  FastingTime get fastingTime {
    return _fastingTime;
  }

  Timer? get timer {
    return _timer;
  }

  FastingData(){
    settingData();
  }


  void settingData() {
    final fastingTimeJson = prefs.getString(Prefs().fastingTime) ??
        _fastingTime.toJson().toString();
    _fastingTime = FastingTime.fromJson(jsonDecode(fastingTimeJson));
    setTargetTime();

    if (_fastingTime.startTime != null) {
      _fastingTime.elapsedTime =
          DateTime.now().difference(_fastingTime.startTime!).inSeconds;
    } else {
      _fastingTime.isFasting = true;
    }
    startTimer();
    notifyListeners();
  }

  void saveFastingTime() {
    prefs.setString(Prefs().fastingTime, jsonEncode(_fastingTime));
  }

  void setTargetTime() {
    final fastingRatio = _fastingTime.fastingRatio;
    final hourString = fastingRatio.contains(":")
        ? fastingRatio.split(":").elementAt(_fastingTime.isFasting ? 0 : 1)
        : fastingRatio;

    _fastingTime.targetTime = Duration(hours: int.parse(hourString)).inSeconds;
    notifyListeners();
  }

  void updateFastingStatus(bool isFasting) {
    _fastingTime.isFasting = isFasting;
    notifyListeners();
  }

  void updateStartTime(DateTime startTime) {
    _fastingTime.startTime = startTime;
    notifyListeners();
  }

  void startTimer() {
    _fastingTime.startTime ??= DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _fastingTime.elapsedTime++;
    });
    saveFastingTime();
    notifyListeners();
  }

  void endTimer(BuildContext context) {
    if (timer != null && timer!.isActive) {
      final result = Navigator.push(context,
              MaterialPageRoute(builder: (context) => CompleteScreen()));

      if(result != null){
        timer?.cancel();
        fastingTime.elapsedTime = 0;
        fastingTime.isFasting = !fastingTime.isFasting;
        setTargetTime();
        startTimer();
        notifyListeners();
      }
    }
  }
}
