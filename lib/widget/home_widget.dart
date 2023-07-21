import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermittent_fasting/model/fasting_time.dart';
import 'package:intermittent_fasting/providers/fasting_data.dart';
import 'package:intermittent_fasting/screen/fasting_rate_screen.dart';
import 'package:intermittent_fasting/widget/common_widget.dart';
import 'package:provider/provider.dart';

import '../utils/time_utils.dart';

class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width - size.width, size.height * 0.8);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 45, bottom: 20),
            child: Text(
              '총 120일간\n진행 하였습니다.',
              style: TextStyle(
                color: Color(0xFF392E5C),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          HistoryTopLabel(),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print("클릭");
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Row(
                        children: [
                          FastingRatioLabel(isFastingScreen: false),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "6/10 오후 6 : 26",
                                  style: const TextStyle(
                                    color: Color(0xff9d9d9d),
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "6/11  오전 4 : 26",
                                  style: const TextStyle(
                                    color: Color(0xff9d9d9d),
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '16시간 25분',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: Color(0xff9D9D9D),
                          )
                        ],
                      ),
                    ),
                    Divider()
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class HistoryTopLabel extends StatelessWidget {
  const HistoryTopLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        const Color(0xffFFB82E).withOpacity(0.3),
        Colors.white,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: ShapeDecoration(
              color: const Color(0xFFFFB72D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(88),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icon_smile.svg',
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      '단식 중',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
              left: 11,
              bottom: 0,
              child: IntrinsicHeight(
                child: SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    color: Color(0xFFFFB72D),
                    thickness: 2,
                  ),
                ),
              )),
          Positioned(
            left: 16,
            bottom: 0,
            child: Container(
              width: 6,
              height: 6,
              decoration: const ShapeDecoration(
                color: Color(0xFFFFB72D),
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTimerView extends StatelessWidget {
  const HomeTimerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const FastingRateScreen(comeStartScreen: false)));
            },
            child: const FastingRatioLabel(editIcon: true),
          ),
        ),
        const TimerCircleProgress(),
      ],
    );
  }
}

class TimerCircleProgress extends StatefulWidget {
  const TimerCircleProgress({
    super.key,
  });

  @override
  State<TimerCircleProgress> createState() => _TimerCircleProgressState();
}

class _TimerCircleProgressState extends State<TimerCircleProgress> {
  late FastingTime fastingTime;
  Timer? timer;

  bool fastingTimeSetting = false;

  int elapsedTime = 0;
  int targetTime = 1;

  @override
  Widget build(BuildContext context) {
    fastingTime = context.select((FastingData data) => data.fastingTime);
    if (!fastingTimeSetting) {
      fastingTimeSetting = true;
      setFastingTime();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: CircularProgressIndicator(
                  value: elapsedTime / targetTime,
                  color: const Color(0xffFFB82E),
                  backgroundColor: const Color(0xffF2F2F2),
                  strokeWidth: 20)),
        ),
        SizedBox(
            width: 280,
            height: 280,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(200),
              ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(" "),
            Text(
              TimeUtils().printDuration(Duration(seconds: elapsedTime)),
              style: const TextStyle(
                color: Color(0xff392e5c),
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text("현재 진행 시간",
                style: TextStyle(
                  color: Color(0xff9d9d9d),
                  fontSize: 12,
                )),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void setFastingTime() {
    if (fastingTime.startTime != null) {
      targetTime = fastingTime.targetTime;
      elapsedTime = DateTime.now().difference(fastingTime.startTime!).inSeconds;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) {
          setState(() {
            elapsedTime++;
          });
        }
      });
    }
  }
}
