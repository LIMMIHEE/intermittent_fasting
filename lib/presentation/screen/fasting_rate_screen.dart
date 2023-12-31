import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:intermittent_fasting/presentation/screen/home_screen.dart';
import 'package:intermittent_fasting/presentation/widget/fasting/fasting_grid_view.dart';
import 'package:intermittent_fasting/presentation/widget/fasting/fasting_tab.dart';
import 'package:jelly_anim/jelly_anim.dart';
import 'package:provider/provider.dart';

class FastingRateScreen extends StatefulWidget {
  const FastingRateScreen({Key? key, required this.comeStartScreen})
      : super(key: key);

  final bool comeStartScreen;

  @override
  State<FastingRateScreen> createState() => _FastingRateScreenState();
}

class _FastingRateScreenState extends State<FastingRateScreen>
    with TickerProviderStateMixin {
  final dayTimeFasting = {
    UniqueKey(): ["12:12", "12시간 단식 12시간 식사"],
    UniqueKey(): ["14:10", "14시간 단식 10시간 식사"],
    UniqueKey(): ["16:8", "16시간 단식 8시간 식사"],
    UniqueKey(): ["18:6", "18시간 단식 6시간 식사"],
    UniqueKey(): ["20:4", "20시간 단식 4시간 식사"],
  };
  final dayFasting = {
    UniqueKey(): ["24시간", "1일 단식"],
    UniqueKey(): ["36시간", "1.5일 단식"],
    UniqueKey(): ["48시간", "2일 단식"],
  };

  late TabController _tabController;
  var isSelect = false;
  UniqueKey? selectWidgetKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignSystem.colors.backgroundClearYellow,
      body: Stack(
        children: [
          JellyAnim(
              jellyCount: 1,
              radius: 400,
              viewPortSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height + 180),
              jellyCoordinates: 12,
              allowOverFlow: true,
              duration: const Duration(minutes: 1),
              colors: [DesignSystem.colors.white],
              jellyPosition: JellyPosition.bottomCenter),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120, bottom: 30),
                child: Text(
                  '단식 비율',
                  style: DesignSystem.typography.display2(),
                ),
              ),
              TabBar(
                onTap: (index) {
                  setState(() {});
                },
                tabs: [
                  FastingTab(
                    tabController: _tabController,
                    title: '하루 단위',
                    index: 0,
                  ),
                  FastingTab(
                    tabController: _tabController,
                    title: '격일 단식',
                    index: 1,
                  ),
                ],
                indicatorColor: Colors.transparent,
                controller: _tabController,
              ),
              Expanded(
                  child: Align(
                alignment: AlignmentDirectional.topStart,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    FastingGridView(
                        selectWidget: selectWidgetKey,
                        fastingMap: dayTimeFasting,
                        onTap: gridTap),
                    FastingGridView(
                        selectWidget: selectWidgetKey,
                        fastingMap: dayFasting,
                        onTap: gridTap)
                  ],
                ),
              )),
              GestureDetector(
                onTap: () {
                  if (isSelect) {
                    var selectFasting = _tabController.index == 0
                        ? dayTimeFasting[selectWidgetKey]?.first as String
                        : dayFasting[selectWidgetKey]?.first as String;

                    context
                        .read<FastingProvider>()
                        .updateFastingRatio(selectFasting);
                    context.read<FastingProvider>().setTargetTime();

                    widget.comeStartScreen
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false)
                        : Navigator.pop(context);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 39, vertical: 48),
                  padding: const EdgeInsets.symmetric(vertical: 19),
                  decoration: ShapeDecoration(
                    color: isSelect
                        ? DesignSystem.colors.appPrimary
                        : DesignSystem.colors.gray700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(88),
                    ),
                  ),
                  child: Text(
                    '완료',
                    style: DesignSystem.typography.heading3(TextStyle(
                      color: DesignSystem.colors.white,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void gridTap(int index, UniqueKey key) {
    setState(() {
      selectWidgetKey = key;
      if (!isSelect) isSelect = true;
    });
  }
}
