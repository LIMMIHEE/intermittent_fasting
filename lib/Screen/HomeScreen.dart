import 'package:flutter/material.dart';

import '../widget/CommonWidget.dart';
import '../widget/HomeWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container()),
            ButtonTab(
              widgetChild: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TimerTextContainer(
                        timeText: "6/10 오후 6 : 26",
                        text: "시작시간",
                      ),
                      Image.asset(
                        'assets/images/time_arrow.png',
                        width: 35,
                      ),
                      TimerTextContainer(
                          timeText: "6/10 오후 6 : 26",
                          text: "종료시간",
                          isEdit: false),
                    ],
                  ),
                ),
                Divider()
              ],
            )
          ],
        ),
      ),
    );
  }
}