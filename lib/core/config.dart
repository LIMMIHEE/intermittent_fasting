import 'package:flutter/material.dart';

class Config {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  static bool isLightTheme() {
    return Config.themeNotifier.value == ThemeMode.light;
  }
}
