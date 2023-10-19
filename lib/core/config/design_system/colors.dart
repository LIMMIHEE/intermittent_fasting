import 'dart:ui';

class Colors {
  Colors._();

  static final Colors _instance = Colors._();

  static Colors get instance => _instance;

  Color get appPrimary => const Color(0xFFFFB82E);

  Color get appSecondary => const Color(0xFF392E5C);

  Color get black => const Color(0xFF000000);

  Color get white => const Color(0xFFFFFFFF);

  Color get gray700 => const Color(0xff9D9D9D);

  Color get gray100 => const Color(0xFFE1E1E1);

  Color get blueGray => const Color(0xFF6E777B);

  Color get deleteRed => const Color(0xFFFA3C3C);

  Color get saveYellow => const Color(0xFFFFB72D);

  // text
  Color get textPrimary => const Color(0xFF392E5C);

  Color get textSecondary => const Color(0xFF8B8B8B);

  Color get textTertiary => const Color(0xFFC0C0C0);

  Color get textDisabled => const Color(0xFFDBDBDB);

  Color get textHint => const Color(0xFFAAAAAA);

  // background
  Color get backgroundDisabled => const Color(0xFFF3F3F3);

  Color get backgroundClearYellow => const Color(0xffFFF1D5);

  //diver
  Color get divider => const Color(0xFFE8E8E8);

  //shadow
  Color get shadow => const Color(0x0C000000);
}
