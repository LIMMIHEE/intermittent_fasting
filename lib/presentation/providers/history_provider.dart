import 'package:flutter/material.dart';
import 'package:intermittent_fasting/data/service/sqlite_helper.dart';
import 'package:intermittent_fasting/domain/entities/fasting_time.dart';
import 'package:intermittent_fasting/domain/entities/history.dart';

class HistoryProvider extends ChangeNotifier {
  static List<History> _list = [];

  List<History> get list {
    return _list;
  }

  HistoryProvider() {
    fetchAndSetHistory();
  }

  // Functions

  static void clearData() {
    _list = [];
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
