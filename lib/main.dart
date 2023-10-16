import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/utils/firebase_utils.dart';
import 'package:intermittent_fasting/core/utils/prefs_utils.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_data.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_history.dart';
import 'package:intermittent_fasting/presentation/screen/home_screen.dart';
import 'package:intermittent_fasting/presentation/screen/start_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsUtils.init();

  FastingHistory();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FastingData()),
      ChangeNotifierProvider(create: (_) => FastingHistory()),
    ],
    child: const MyApp(),
  ));
}

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '간헐적 단식',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrefsUtils.getString(PrefsUtils.uid).isNotEmpty
          ? const HomeScreen()
          : const StartScreen(),
    );
  }
}
