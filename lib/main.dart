import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '간헐적 단식',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Text("간헐적 단식을 위한 어플입니다."),
    );
  }
}