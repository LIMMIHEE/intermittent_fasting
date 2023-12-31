import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config.dart';
import 'package:intermittent_fasting/core/utils/firebase_utils.dart';
import 'package:intermittent_fasting/core/utils/prefs_utils.dart';
import 'package:intermittent_fasting/presentation/screen/home_screen.dart';
import 'package:intermittent_fasting/presentation/screen/start_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseUtils firebaseUtils = FirebaseUtils();

  @override
  void initState() {
    firebaseUtils.firebaseSetting();
    setThemeMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: Config.themeNotifier,
        builder: (_, ThemeMode currentMode, child) {
          return MaterialApp(
            title: '간헐적 단식',
            theme: ThemeData(
              primarySwatch: Colors.amber,
            ),
            home: PrefsUtils.getString(PrefsUtils.uid).isNotEmpty
                ? const HomeScreen()
                : const StartScreen(),
          );
        });
  }

  void setThemeMode() {
    var darkModeOn = PrefsUtils.getBool(PrefsUtils.darkMode);
    Config.themeNotifier.value = darkModeOn ? ThemeMode.dark : ThemeMode.light;
  }
}
