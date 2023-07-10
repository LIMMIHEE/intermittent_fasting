import 'package:flutter/material.dart';
import 'package:intermittent_fasting/model/history.dart';
import 'package:intermittent_fasting/service/sqlite_helper.dart';
import 'package:intermittent_fasting/utils/globals.dart';
import 'package:intermittent_fasting/utils/prefs.dart';

class FastingHistory extends ChangeNotifier {
  List<History> _list = [];

  List<History> get list {
    return [...list];
  }

  void addHistory(DateTime startTime, int targetTime) {
    final newHistory = History(
        startDate: startTime.toString(),
        endDate: startTime.add(Duration(seconds: targetTime)).toString(),
        fastingRatio: prefs.getString(Prefs().fastingTimeRatio) ?? '',
        memo: '');

    _list.add(newHistory);
    notifyListeners();

    SQLiteHelper.insertHistory(newHistory);
  }

  void updateHistoryMemo(int id, String memo) {
    final updateHistory = SQLiteHelper.getHistory(id);

    updateHistory.then((history) {
      history.memo = memo;
      SQLiteHelper.updateHistory(history);
    });
    notifyListeners();
  }

  Future<void> fetchAndSetHistory() async {
    _list = await SQLiteHelper.loadHistory();

    notifyListeners();
  }
}
