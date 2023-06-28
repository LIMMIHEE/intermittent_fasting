import 'package:flutter/material.dart';

import '../Utils/time_utils.dart';


class TimerTextContainer extends StatelessWidget {
  const TimerTextContainer(
      {super.key,
        required this.text,
        required this.timeText,
        this.isEdit = true});

  final String text;
  final String timeText;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xff392e5c),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
              Visibility(
                visible: isEdit,
                child: GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.edit,
                      size: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            timeText,
            style: const TextStyle(
              color: Color(0xff9d9d9d),
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}

class TimerCircleProgress extends StatelessWidget {
  const TimerCircleProgress({
    super.key,
    required this.elapsedTime,
    required this.targetTime,
  });

  final int elapsedTime;
  final int targetTime;

  @override
  Widget build(BuildContext context) {
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
              TimeUtils()
                  .printDuration(Duration(seconds: elapsedTime)),
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
}

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
