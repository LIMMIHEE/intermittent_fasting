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

  void addHistory(FastingTime fastingTime, String endTime) {
    final newHistory = History(
        startDate: fastingTime.startTime.toString(),
        endDate: endTime,
        fastingRatio: fastingTime.fastingRatio,
        memo: '');

    SQLiteHelper.insertHistory(newHistory);
    _list.add(newHistory);
    _notify();
  }

  void updateHistoryMemo(int id, String memo) {
    final updateHistory = SQLiteHelper.getHistory(id);

    updateHistory.then((history) {
      history.memo = memo;
      _list.where((element) => element.id == id).forEach((element) {
        element.memo = memo;
      });
      SQLiteHelper.updateHistory(history);
    });

    _notify();
  }

  void deleteHistory(History history) {
    SQLiteHelper.deleteHistory(history).then((value) {
      _list.remove(history);
      _notify();
    });
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
