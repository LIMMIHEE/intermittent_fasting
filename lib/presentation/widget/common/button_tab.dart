import 'package:flutter/material.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:intermittent_fasting/presentation/widget/common/button_tab_item.dart';
import 'package:provider/provider.dart';

class ButtonTab extends StatelessWidget {
  const ButtonTab(
      {super.key, required this.widgetChild, required this.tabController});

  final TabController tabController;
  final List<Widget> widgetChild;

  @override
  Widget build(BuildContext context) {
    final fastingTime = context.read<FastingProvider>().fastingTime;
    final isTimerActive = context.read<FastingProvider>().isTimerActive;

    return Container(
      height: tabController.index == 0 ? 260 : 145,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 19),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                ...widgetChild,
                Padding(
                  padding:
                      EdgeInsets.only(top: widgetChild.isNotEmpty ? 15 : 0),
                  child: TabBar(
                    tabs: const [
                      ButtonTabItem(
                        icon: Icons.timer,
                        title: "단식",
                      ),
                      ButtonTabItem(
                        icon: Icons.sticky_note_2,
                        title: "기록",
                      ),
                      ButtonTabItem(
                        icon: Icons.insert_chart_rounded,
                        title: "분석",
                      ),
                      ButtonTabItem(
                        icon: Icons.settings,
                        title: "설정",
                      )
                    ],
                    labelColor: const Color(0xffFFB82E),
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.transparent,
                    controller: tabController,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 186,
            child: GestureDetector(
              onTap: () {
                if (!isTimerActive) {
                  context.read<FastingProvider>().startTimeSet();
                } else {
                  context.read<FastingProvider>().endTimeSet(context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Container(
                  width: 110,
                  height: 45,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFB82E),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffFFB82E).withOpacity(0.2),
                        blurRadius: 3,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fastingTime.startTime == null ? "시작" : "종료",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Icon(
                          fastingTime.startTime == null
                              ? Icons.play_arrow_rounded
                              : Icons.pause,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
