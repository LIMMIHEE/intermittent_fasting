import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/core/utils/prefs_utils.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:intermittent_fasting/presentation/providers/history_provider.dart';
import 'package:intermittent_fasting/presentation/widget/common/timer_row_container.dart';
import 'package:provider/provider.dart';
import 'package:jelly_anim/jelly_anim.dart';

class CompleteScreen extends StatelessWidget {
  CompleteScreen({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fastingTime = context.read<FastingProvider>().fastingTime;
    final isFastingTimeDone = fastingTime.isFasting;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ColoredBox(
        color: DesignSystem.colors.appPrimary.withOpacity(0.2),
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
                colors: [DesignSystem.colors.white.withOpacity(0.2)],
                jellyPosition: JellyPosition.bottomCenter),
            Column(
              children: [
                Image.asset(
                  'assets/images/img_complete_${isFastingTimeDone ? 'fasting' : 'eating'}_time.png',
                  width: 350,
                ),
                Padding(
                  padding: EdgeInsets.only(top: isFastingTimeDone ? 120 : 25),
                  child: timeColumn(fastingTime.startTime),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Visibility(
                    visible: !isFastingTimeDone,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '식단 메모',
                            style: DesignSystem.typography.heading3(),
                          ),
                          TextField(
                            maxLines: 9,
                            controller: controller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "오늘의 식단 일기 등을 적어주세요!",
                                labelStyle: DesignSystem.typography.caption1()),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
                GestureDetector(
                  onTap: () async {
                    context.read<FastingProvider>().endTimeSet();
                    if (isFastingTimeDone) {
                      context
                          .read<HistoryProvider>()
                          .addHistory(fastingTime, DateTime.now().toString());
                    } else if (!isFastingTimeDone &&
                        controller.text.isNotEmpty) {
                      final id = PrefsUtils.getInt(PrefsUtils.nowEatHistoryId);
                      context
                          .read<HistoryProvider>()
                          .updateHistoryMemo(id, controller.text);
                    }
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
                          ? DesignSystem.colors.white
                          : DesignSystem.colors.appPrimary,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 0.75, color: DesignSystem.colors.appPrimary),
                        borderRadius: BorderRadius.circular(56),
                      ),
                    ),
                    child: Text(
                      isFastingTimeDone ? '식사 시간 시작' : '단식 시간 시작',
                      style: TextStyle(
                        color: isFastingTimeDone
                            ? DesignSystem.colors.appPrimary
                            : DesignSystem.colors.white,
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

  Widget timeColumn(startTime) {
    final elapsedTime = DateTime.now().difference(startTime!).inSeconds;
    final hours = (Duration(seconds: elapsedTime).inMinutes / 60).truncate();
    final minutes = Duration(seconds: elapsedTime).inMinutes % 60;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text(
              '$hours:$minutes',
              style: DesignSystem.typography.heading1(
                  const TextStyle(fontSize: 55, fontWeight: FontWeight.w700)),
            ),
          ),
          const TimerRowContainer()
        ],
      ),
    );
  }
}
