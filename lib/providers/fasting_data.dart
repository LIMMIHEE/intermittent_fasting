import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intermittent_fasting/model/fasting_time.dart';
import 'package:intermittent_fasting/screen/complete_screen.dart';
import 'package:intermittent_fasting/utils/globals.dart';
import 'package:intermittent_fasting/utils/prefs.dart';

class FastingData extends ChangeNotifier {
  static FastingTime _fastingTime = FastingTime();
  static bool _isTimerActive = false;

  FastingTime get fastingTime {
    return _fastingTime;
  }

  bool get isTimerActive {
    return _isTimerActive;
  }

  FastingData() {
    settingData();
  }

  void settingData() {
    final fastingTimeJson = prefs.getString(Prefs().fastingTime) ??
        _fastingTime.toJson().toString();
    _fastingTime = FastingTime.fromJson(jsonDecode(fastingTimeJson));
    setTargetTime();

    if (_fastingTime.startTime == null) {
      _fastingTime.isFasting = true;
    } else {
      _isTimerActive = true;
    }
    startTimeSet();
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
    saveFastingTime();

    notifyListeners();
  }

  void startTimeSet() {
    _fastingTime.startTime ??= DateTime.now();

    saveFastingTime();
    notifyListeners();
  }

  void endTimeSet(BuildContext context) {
    final result = Navigator.push(
        context, MaterialPageRoute(builder: (context) => CompleteScreen()));

    if (result != null) {
      fastingTime.isFasting = !fastingTime.isFasting;
      setTargetTime();
      startTimeSet();
      notifyListeners();
    }
  }
}
