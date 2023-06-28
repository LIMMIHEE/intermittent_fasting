import 'package:flutter/material.dart';
import 'package:intermittent_fasting/Screen/start_screen.dart';
import 'package:intermittent_fasting/Utils/firebase_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
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
      home: StartScreen(),
    );
  }
}
