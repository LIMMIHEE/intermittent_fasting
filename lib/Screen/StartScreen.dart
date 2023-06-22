import 'package:flutter/material.dart';
import 'package:intermittent_fasting/widget/StartWidget.dart';
import 'package:jelly_anim/jelly_anim.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          JellyAnim(
              jellyCount: 1,
              radius: 90,
              viewPortSize: const Size(900, 600),
              jellyCoordinates: 4,
              allowOverFlow: true,
              duration: const Duration(minutes: 1),
              colors: [const Color(0xffFFB82E).withOpacity(0.32)],
              jellyPosition: JellyPosition.topLeft),
          JellyAnim(
              jellyCount: 1,
              radius: 330,
              viewPortSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height + 200),
              jellyCoordinates: 12,
              allowOverFlow: true,
              duration: const Duration(minutes: 1),
              colors: [const Color(0xffFFB82E).withOpacity(0.32)],
              jellyPosition: JellyPosition.bottomCenter),
          OverlappingWidget()
        ],
      ),
    );
  }
}

class OverlappingWidget extends StatefulWidget {
  var status = "welecome";

  OverlappingWidget({super.key});

  @override
  State<OverlappingWidget> createState() => StartWidgetState();
}
