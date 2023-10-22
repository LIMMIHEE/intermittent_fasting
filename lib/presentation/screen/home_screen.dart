import 'package:flutter/material.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:intermittent_fasting/presentation/widget/analysis/analysis_view.dart';
import 'package:intermittent_fasting/presentation/widget/common/button_tab.dart';
import 'package:intermittent_fasting/presentation/widget/common/timer_row_container.dart';
import 'package:intermittent_fasting/presentation/widget/history/history_list_view.dart';
import 'package:intermittent_fasting/presentation/widget/home/home_timer_view.dart';
import 'package:intermittent_fasting/presentation/widget/setting/setting_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<FastingProvider>().isClearAfter) {
        context.read<FastingProvider>().settingData();
      }
    });
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: const [
              HomeTimerView(),
              HistoryListView(),
              AnalysisView(),
              SettingView(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonTab(
              tabController: _tabController,
              widgetChild: _tabController.index == 0
                  ? [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TimerRowContainer(isHomeScreen: true),
                      ),
                      const Divider()
                    ]
                  : [],
            ),
          )
        ],
      ),
    );
  }
}
