import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:intermittent_fasting/presentation/screen/complete_screen.dart';
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

    return SizedBox(
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
              color: DesignSystem.colors.white,
              boxShadow: [
                BoxShadow(
                  color: DesignSystem.colors.black.withOpacity(0.2),
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
                    labelColor: DesignSystem.colors.appPrimary,
                    unselectedLabelColor: DesignSystem.colors.black,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompleteScreen(
                                fastingTime: fastingTime,
                              )));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: DesignSystem.colors.backgroundWhite,
                    borderRadius: BorderRadius.circular(50)),
                child: Container(
                  width: 110,
                  height: 45,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: DesignSystem.colors.appPrimary,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: DesignSystem.colors.appPrimary.withOpacity(0.2),
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
                        style: DesignSystem.typography.heading4(TextStyle(
                            color: DesignSystem.colors.white,
                            fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Icon(
                          fastingTime.startTime == null
                              ? Icons.play_arrow_rounded
                              : Icons.pause,
                          color: DesignSystem.colors.white,
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
