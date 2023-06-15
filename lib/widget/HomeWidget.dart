import 'package:flutter/material.dart';

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
