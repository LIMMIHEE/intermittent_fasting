import 'package:flutter/material.dart';
import 'package:intermittent_fasting/model/fasting_time.dart';
import 'package:intermittent_fasting/model/history.dart';
import 'package:intermittent_fasting/service/sqlite_helper.dart';

class FastingHistory extends ChangeNotifier {
  static List<History> _list = [];

  List<History> get list {
    return _list;
  }

  FastingHistory() {
    fetchAndSetHistory();
  }

  void addHistory(FastingTime fastingTime) {
    final newHistory = History(
        startDate: fastingTime.startTime.toString(),
        endDate: fastingTime.startTime!
            .add(Duration(seconds: fastingTime.targetTime))
            .toString(),
        fastingRatio: fastingTime.fastingRatio,
        memo: '');

    SQLiteHelper.insertHistory(newHistory);
    _notify();
  }

  void updateHistoryMemo(int id, String memo) {
    final updateHistory = SQLiteHelper.getHistory(id);

    updateHistory.then((history) {
      history.memo = memo;
      SQLiteHelper.updateHistory(history);
    });

    _notify();
  }

  }

  Future<void> fetchAndSetHistory() async {
    _list = await SQLiteHelper.loadHistory();

    notifyListeners();
  }

  void _notify() {
    _list = [..._list];
    notifyListeners();
  }
}
