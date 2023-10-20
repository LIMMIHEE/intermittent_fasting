import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config.dart';
import 'package:intermittent_fasting/core/utils/prefs_utils.dart';
import 'package:intermittent_fasting/data/service/sqlite_helper.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:intermittent_fasting/presentation/providers/history_provider.dart';

class SettingProvider extends ChangeNotifier {
  bool isDarkMode = false;

  SettingProvider() {
    isDarkMode = Config.themeNotifier.value == ThemeMode.dark;
  }

  void changeTheme(bool isDark) {
    Config.themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    PrefsUtils.setBool(PrefsUtils.darkMode, isDark);
    isDarkMode = isDark;
    notifyListeners();
  }

  Future<void> allDataClear(Function() clearAfter) async {
    await SQLiteHelper.clearHistory();
    await PrefsUtils.clear();

    FastingProvider.clearData();
    HistoryProvider.clearData();
    clearAfter();
  }
}
