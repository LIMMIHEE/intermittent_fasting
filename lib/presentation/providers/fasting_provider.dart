import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/utils/prefs_utils.dart';
import 'package:intermittent_fasting/domain/entities/fasting_time.dart';

class FastingProvider extends ChangeNotifier {
  static FastingTime _fastingTime = FastingTime();
  static bool _isTimerActive = false;
  static bool _isClearAfter = false;

  FastingTime get fastingTime {
    return _fastingTime;
  }

  bool get isTimerActive {
    return _isTimerActive;
  }

  bool get isClearAfter {
    return _isClearAfter;
  }

  FastingProvider() {
    settingData();
  }

  // Functions

  void settingData() {
    String fastingTimeJson = PrefsUtils.getString(PrefsUtils.fastingTime);
    if (fastingTimeJson.isEmpty) {
      fastingTimeJson = jsonEncode(_fastingTime);
    }
    _fastingTime = FastingTime.fromJson(jsonDecode(fastingTimeJson));
    setTargetTime();

    if (_fastingTime.startTime == null) {
      _fastingTime.isFasting = true;
    } else {
      _isTimerActive = true;
      startTimeSet();
    }
    notifyListeners();
  }

  static void clearData() {
    _fastingTime = FastingTime();
    _isTimerActive = false;
    _isClearAfter = true;
  }

  void saveFastingTime() {
    PrefsUtils.setString(PrefsUtils.fastingTime, jsonEncode(_fastingTime));
  }

  void setTargetTime() {
    final fastingRatio = _fastingTime.fastingRatio;
    String hourString = fastingRatio.contains(":")
        ? fastingRatio.split(":").elementAt(_fastingTime.isFasting ? 0 : 1)
        : fastingRatio;
    if (hourString.contains("시간")) {
      hourString = hourString.replaceAll("시간", '');
    }

    _fastingTime.targetTime = Duration(hours: int.parse(hourString)).inSeconds;
    _saveNotify();
  }

  void updateFastingStatus(bool isFasting) {
    _fastingTime.isFasting = isFasting;
    _saveNotify();
  }

  void updateFastingRatio(String fastingRatio) {
    _fastingTime.fastingRatio = fastingRatio;
  }

  void updateStartTime(DateTime startTime) {
    _fastingTime.startTime = startTime;
    _saveNotify();
  }

  void startTimeSet() {
    _fastingTime.startTime ??= DateTime.now();
    _isTimerActive = true;
    _saveNotify();
  }

  void endTimeSet() {
    _fastingTime.isFasting = !_fastingTime.isFasting;
    _fastingTime.startTime = DateTime.now();
    _saveNotify();
  }

  void _saveNotify() {
    _fastingTime = _fastingTime.copyWith(
        isFasting: _fastingTime.isFasting,
        startTime: _fastingTime.startTime ?? DateTime.now(),
        fastingRatio: _fastingTime.fastingRatio,
        targetTime: _fastingTime.targetTime);
    saveFastingTime();
    notifyListeners();
  }
}
