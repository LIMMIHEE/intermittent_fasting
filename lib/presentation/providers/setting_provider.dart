import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config.dart';

class SettingProvider extends ChangeNotifier {
  bool isDarkMode = false;

  SettingProvider() {
    isDarkMode = Config.themeNotifier.value == ThemeMode.dark;
  }

  void changeTheme(bool isDark) {
    Config.themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    isDarkMode = isDark;
    notifyListeners();
  }
}
