import 'package:flutter/material.dart';
import 'package:intermittent_fasting/Screen/start_screen.dart';
import 'package:intermittent_fasting/Utils/firebase_utils.dart';
import 'package:intermittent_fasting/model/history.dart';
import 'package:intermittent_fasting/providers/fasting_data.dart';
import 'package:intermittent_fasting/providers/fasting_history.dart';
import 'package:intermittent_fasting/screen/home_screen.dart';
import 'package:intermittent_fasting/utils/prefs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  isLogin = prefs.getString(Prefs().uid) != null;

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
      home: isLogin ? const HomeScreen() : const StartScreen(),
    );
  }
}
