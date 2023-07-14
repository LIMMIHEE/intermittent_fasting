import 'package:flutter/material.dart';
import 'package:intermittent_fasting/providers/fasting_data.dart';
import 'package:intermittent_fasting/screen/fasting_rate_screen.dart';
import 'package:provider/provider.dart';

import '../widget/common_widget.dart';
import '../widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => FastingData(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  top: 0,
                  child: ClipPath(
                    clipper: CustomPath(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB82E).withOpacity(0.2),
                      ),
                      width: 300,
                      height: 140,
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FastingRateScreen(
                                  comeStartScreen: false)));
                    },
                    child: const FastingRatioLabel(editIcon: true),
                  ),
                ),
                const TimerCircleProgress(),
              ],
            )),
            const ButtonTab(
              widgetChild: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: TimerRowContainer(),
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
