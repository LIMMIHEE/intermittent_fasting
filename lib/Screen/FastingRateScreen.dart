import 'package:flutter/material.dart';
import 'package:jelly_anim/jelly_anim.dart';

import '../widget/FastingWidget.dart';

class FastingRateScreen extends StatefulWidget {
  const FastingRateScreen({Key? key}) : super(key: key);

  @override
  State<FastingRateScreen> createState() => _FastingRateScreenState();
}

class _FastingRateScreenState extends State<FastingRateScreen>
    with TickerProviderStateMixin {
  final dayTimeFasting = {
    "12:12": "12시간 단식 12시간 식사",
    "14:10": "14시간 단식 10시간 식사",
    "16:8": "16시간 단식 8시간 식사",
    "18:6": "18시간 단식 6시간 식사",
    "20:4": "20시간 단식 4시간 식사",
    "커스텀": "원하는 비율로 설정",
  };
  final dayFasting = {
    "24시간": "1일 단식",
    "36시간": "1.5일 단식",
    "48시간": "2일 단식",
    "커스텀": "원하는 시간으로 설정",
  };

  late TabController _tabController;
  var isSelect = false;
  var selectTab = 0;

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
                  if (index != selectTab) {
                    setState(() {
                      selectTab = index;
                    });
                  }
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
                        fastingMap: dayTimeFasting,
                        onTap: (index) {
                          setState(() {
                            selectTab = index;
                          });
                        }),
                    FastingGridView(
                        fastingMap: dayFasting,
                        onTap: (index) {
                          setState(() {
                            selectTab = index;
                          });
                        })
                  ],
                ),
              )),
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 39, vertical: 48),
                  padding: const EdgeInsets.symmetric(vertical: 19),
                  decoration: ShapeDecoration(
                    color: isSelect ? Color(0xFFFFB72D) : Color(0xff9D9D9D),
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
}
