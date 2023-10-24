import 'dart:ui';

import 'package:intermittent_fasting/core/config.dart';

abstract class _LightScheme {
  static const Color appPrimary = Color(0xFFFFB82E);
  static const Color appSecondary = Color(0xFF392E5C);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray100 = Color(0xFFE1E1E1);
  static const Color gray500 = Color(0xFF8B8B8B);
  static const Color gray700 = Color(0xff9D9D9D);
  static const Color gray900 = Color(0xFFF3F3F3);
  static const Color blueGray = Color(0xFF6E777B);
  static const Color saveYellow = Color(0xFFFFB72D);
  static const Color deleteRed = Color(0xFFFA3C3C);
  static const Color shadow = Color(0x0C000000);
  static const Color clearYellow = Color(0xffFFF1D5);
  static const Color textPrimary = Color(0xFF392E5C);
  static const Color divider = Color(0xFFC9C9C9);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
}

abstract class _DarkScheme {
  static const Color appPrimary = Color(0xFF392E5C);
  static const Color appSecondary = Color(0xFFFFB82E);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray100 = Color(0xff9D9D9D);
  static const Color gray500 = Color(0xFF8B8B8B);
  static const Color gray700 = Color(0xff9D9D9D);
  static const Color gray900 = Color(0xFFE1E1E1);
  static const Color blueGray = Color(0xFFBFCED5);
  static const Color saveYellow = Color(0xFFFFB72D);
  static const Color deleteRed = Color(0xFFFA3C3C);
  static const Color shadow = Color(0x0cffffff);
  static const Color clearYellow = Color(0xff544d42);
  static const Color textPrimary = Color(0xFF392E5C);
  static const Color divider = Color(0xFFC9C9C9);
  static const Color backgroundWhite = Color(0xFF171326);
}

class Colors {
  Colors._();

  static final Colors _instance = Colors._();

  static Colors get instance => _instance;

  Color get mainColor => const Color(0xFFFFB82E);

  Color get appPrimary =>
      Config.isLightTheme() ? _LightScheme.appPrimary : _DarkScheme.appPrimary;

  Color get appSecondary => Config.isLightTheme()
      ? _LightScheme.appSecondary
      : _DarkScheme.appSecondary;

  Color get black =>
      Config.isLightTheme() ? _LightScheme.black : _DarkScheme.black;

  Color get white =>
      Config.isLightTheme() ? _LightScheme.white : _DarkScheme.white;

  Color get gray700 =>
      Config.isLightTheme() ? _LightScheme.gray700 : _DarkScheme.gray700;

  Color get gray100 =>
      Config.isLightTheme() ? _LightScheme.gray100 : _DarkScheme.gray100;

  Color get blueGray =>
      Config.isLightTheme() ? _LightScheme.blueGray : _DarkScheme.blueGray;

  Color get deleteRed =>
      Config.isLightTheme() ? _LightScheme.deleteRed : _DarkScheme.deleteRed;

  Color get saveYellow =>
      Config.isLightTheme() ? _LightScheme.saveYellow : _DarkScheme.saveYellow;

  // text
  Color get textPrimary => Config.isLightTheme()
      ? _LightScheme.textPrimary
      : _DarkScheme.textPrimary;

  Color get textSecondary =>
      Config.isLightTheme() ? _LightScheme.gray500 : _DarkScheme.gray500;

  // background
  Color get backgroundDisabled =>
      Config.isLightTheme() ? _LightScheme.gray900 : _DarkScheme.gray900;

  Color get backgroundWhite => Config.isLightTheme()
      ? _LightScheme.backgroundWhite
      : _DarkScheme.backgroundWhite;

  Color get backgroundClearYellow => Config.isLightTheme()
      ? _LightScheme.clearYellow
      : _DarkScheme.clearYellow;

  //divider
  Color get divider =>
      Config.isLightTheme() ? _LightScheme.divider : _DarkScheme.divider;

  //shadow
  Color get shadow =>
      Config.isLightTheme() ? _LightScheme.shadow : _DarkScheme.shadow;
}
