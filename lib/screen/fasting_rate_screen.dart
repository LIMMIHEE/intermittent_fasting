import 'package:flutter/material.dart';
import 'package:intermittent_fasting/Screen/home_screen.dart';
import 'package:intermittent_fasting/Utils/globals.dart';
import 'package:jelly_anim/jelly_anim.dart';

import '../Utils/prefs.dart';
import '../widget/fasting_widget.dart';

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
  UniqueKey? selectWigetKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF1D5),
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
              colors: const [Colors.white],
              jellyPosition: JellyPosition.bottomCenter),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 120, bottom: 30),
                child: Text(
                  '단식 비율',
                  style: TextStyle(
                    color: Color(0xFF392E5C),
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
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
                        selectWidget: selectWigetKey,
                        fastingMap: dayTimeFasting,
                        onTap: gridTap),
                    FastingGridView(
                        selectWidget: selectWigetKey,
                        fastingMap: dayFasting,
                        onTap: gridTap)
                  ],
                ),
              )),
              GestureDetector(
                onTap: () {
                  if (isSelect) {
                    var selectFasting = _tabController.index == 0
                        ? dayTimeFasting[selectWigetKey]?.first
                        : dayFasting[selectWigetKey]?.first;

                    prefs.setString(Prefs().FASTINGTIMERATIO, selectFasting);
                    prefs.setInt(Prefs().FASTINGTIME,
                        int.parse(selectFasting!.substring(0, 2)));

                    widget.comeStartScreen
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false)
                        : Navigator.pop(
                            context, int.parse(selectFasting!.substring(0, 2)));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 39, vertical: 48),
                  padding: const EdgeInsets.symmetric(vertical: 19),
                  decoration: ShapeDecoration(
                    color: isSelect ? const Color(0xFFFFB72D) : const Color(0xff9D9D9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(88),
                    ),
                  ),
                  child: const Text(
                    '완료',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
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
      selectWigetKey = key;
      if (!isSelect) isSelect = true;
    });
  }
}
