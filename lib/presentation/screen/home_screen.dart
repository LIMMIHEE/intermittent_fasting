import 'package:flutter/material.dart';
import 'package:intermittent_fasting/presentation/widget/history_widget.dart';

import '../widget/common_widget.dart';
import '../widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
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
            children: [
              const HomeTimerView(),
              const HistoryListView(),
              Container(),
              Container(),
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
