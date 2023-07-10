import 'package:flutter/material.dart';
import 'package:intermittent_fasting/model/history.dart';
import 'package:intermittent_fasting/service/sqlite_helper.dart';
import 'package:intermittent_fasting/utils/globals.dart';
import 'package:intermittent_fasting/utils/prefs.dart';
import 'package:intermittent_fasting/widget/common_widget.dart';
import 'package:provider/provider.dart';
import 'package:intermittent_fasting/providers/fasting_history.dart';
import 'package:jelly_anim/jelly_anim.dart';

class CompleteScreen extends StatelessWidget {
  CompleteScreen(
      {Key? key, required this.progressTime, required this.isFastingTimeDone})
      : super(key: key);

  final int progressTime;
  final bool isFastingTimeDone;

  final TextEditingController controller = TextEditingController();

  final startTime = DateTime.parse(
      prefs.getString(Prefs().timerStartTime) ?? DateTime.now().toString());
  final targetTime =
      Duration(hours: prefs.getInt(Prefs().fastingTime) ?? 0).inSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: const Color(0xFFFFB82E).withOpacity(0.2),
        child: Stack(
          children: [
            JellyAnim(
                jellyCount: 1,
                radius: 400,
                viewPortSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height +
                        (isFastingTimeDone ? 180 : 300)),
                jellyCoordinates: 12,
                allowOverFlow: true,
                duration: const Duration(minutes: 1),
                colors: const [Color(0xFFFFFCF7)],
                jellyPosition: JellyPosition.bottomCenter),
            Column(
              children: [
                Image.asset(
                  'assets/images/img_complete_${isFastingTimeDone ? 'fasting' : 'eating'}_time.png',
                  width: 350,
                ),
                Padding(
                  padding: EdgeInsets.only(top: isFastingTimeDone ? 120 : 25),
                  child: timeColumn(),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Visibility(
                    visible: !isFastingTimeDone,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          '식단 메모',
                          style: TextStyle(
                            color: Color(0xFF392E5C),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          maxLines: 9,
                          controller: controller,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "오늘의 식단 일기 등을 적어주세요!",
                              labelStyle: TextStyle(
                                color: Color(0xFF392E5C),
                                fontSize: 12,
                              )),
                        )
                      ],
                    ),
                  ),
                )),
                GestureDetector(
                  onTap: () async {
                    if (isFastingTimeDone) {
                      context
                          .read<FastingHistory>()
                          .addHistory(startTime, targetTime);
                    } else if (!isFastingTimeDone &&
                        controller.text.isNotEmpty) {
                      final id = prefs.getInt(Prefs().nowEatHistoryId) ?? 0;
                      context
                          .read<FastingHistory>()
                          .updateHistoryMemo(id, controller.text);
                    }

                    prefs.setBool(Prefs().isFastingTime, !isFastingTimeDone);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    alignment: AlignmentDirectional.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 40),
                    decoration: ShapeDecoration(
                      color: isFastingTimeDone
                          ? Colors.white
                          : const Color(0xFFFFB72D),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.75, color: Color(0xFFFFB72D)),
                        borderRadius: BorderRadius.circular(56),
                      ),
                    ),
                    child: Text(
                      isFastingTimeDone ? '식사 시간 시작' : '단식 시간 시작',
                      style: TextStyle(
                        color: isFastingTimeDone
                            ? const Color(0xFFFFB72D)
                            : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget timeColumn() {
    final hours = (Duration(seconds: progressTime).inMinutes / 60).truncate();
    final minutes = Duration(seconds: progressTime).inMinutes % 60;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text(
              '$hours:$minutes',
              style: const TextStyle(
                color: Color(0xFF392E5C),
                fontSize: 55,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TimerRowContainer(
            startTime: startTime,
            endTime: isFastingTimeDone
                ? startTime.add(Duration(seconds: targetTime))
                : DateTime.now(),
            editTime: 'end',
          )
        ],
      ),
    );
  }
}
