import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/utils/prefs_utils.dart';
import 'package:intermittent_fasting/presentation/app.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:intermittent_fasting/presentation/providers/history_provider.dart';
import 'package:intermittent_fasting/presentation/providers/setting_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsUtils.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FastingProvider()),
      ChangeNotifierProvider(create: (_) => SettingProvider()),
      ChangeNotifierProvider(create: (_) => HistoryProvider()),
    ],
    child: const MyApp(),
  ));
}
