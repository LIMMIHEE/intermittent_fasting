import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermittent_fasting/model/history.dart';
import 'package:intermittent_fasting/providers/fasting_data.dart';
import 'package:intermittent_fasting/providers/fasting_history.dart';
import 'package:intermittent_fasting/widget/common_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyList =
        context.select((FastingHistory history) => history.list);

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 45, bottom: 20),
              child: Text(
                '총 ${historyList.length}일간\n진행 하였습니다.',
                style: const TextStyle(
                  color: Color(0xFF392E5C),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const HistoryTopLabel(),
            historyList.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text("기록이 비어있습니다!"),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: historyList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final history = historyList[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: historyList.length - 1 == index
                                      ? 120
                                      : 0),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return HistoryBottomSheet(
                                        history: history,
                                      );
                                    },
                                  );
                                },
                                child: HistoryListItem(history: history),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({super.key, required this.history});

  final History history;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              FastingRatioLabel(
                  isFastingScreen: false, ratio: history.fastingRatio),
              Expanded(
                child: Column(
                  children: [
                    HistoryTimeText(
                      timeText: history.startDate,
                    ),
                    HistoryTimeText(
                      timeText: history.endDate,
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: HistoryFastingTimeText(
                    history: history,
                    fontSize: 16,
                  )),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Color(0xff9D9D9D),
              )
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}

class HistoryBottomSheet extends StatelessWidget {
  const HistoryBottomSheet({super.key, required this.history});

  final History history;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    '식단 메모',
                    style: TextStyle(
                      color: Color(0xFF392E5C),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  history.memo,
                  style: const TextStyle(
                    color: Color(0xFF392E5C),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              Row(
                children: [
                  FastingRatioLabel(
                    isFastingScreen: false,
                    editIcon: true,
                    ratio: history.fastingRatio,
                  ),
                  Expanded(
                    child: HistoryFastingTimeText(
                      history: history,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    HistoryTimeText(
                      timeText: history.startDate,
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/images/icon_time_arrow.png',
                        width: 35,
                        height: 35,
                      ),
                    ),
                    HistoryTimeText(
                      timeText: history.endDate,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: Platform.isIOS ? 15 : 0,
                ),
                child: Row(
                  children: [
                    HistorySheetButton(
                      onTap: () {
                        context.read<FastingHistory>().deleteHistory(history);
                      },
                      isDeleteButton: true,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    HistorySheetButton(
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class HistoryFastingTimeText extends StatelessWidget {
  const HistoryFastingTimeText(
      {super.key, required this.history, this.fontSize = 18});

  final History history;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      fastingTimeText(history),
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  String fastingTimeText(History history) {
    final difference = DateTime.parse(history.endDate)
        .difference(DateTime.parse(history.startDate))
        .toString()
        .split(":");
    return '${difference.first}시간 ${difference.elementAt(1)}분';
  }
}

class HistoryTimeText extends StatelessWidget {
  const HistoryTimeText(
      {super.key, required this.timeText, this.fontSize = 16});

  final String timeText;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      dateFormatText(timeText),
      style: TextStyle(
        color: const Color(0xFF9D9D9D),
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  String dateFormatText(String date) {
    return DateFormat("M/d HH : mm").format(DateTime.parse(date));
  }
}

class HistorySheetButton extends StatelessWidget {
  const HistorySheetButton(
      {super.key, required this.onTap, this.isDeleteButton = false});

  final Function() onTap;
  final bool isDeleteButton;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: isDeleteButton
                  ? const Color(0xFFFA3C3C)
                  : const Color(0xFFFFB72D),
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Text(
              isDeleteButton ? '기록 삭제' : '저장 및 닫기',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryTopLabel extends StatelessWidget {
  const HistoryTopLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fastingState =
        context.select((FastingData data) => data.fastingTime).isFasting;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        const Color(0xffFFB82E).withOpacity(0.3),
        Colors.white,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: ShapeDecoration(
              color: const Color(0xFFFFB72D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(88),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icon_${fastingState ? 'fire' : 'smile'}.svg',
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      fastingState ? '단식 중' : '식사 중',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
              left: 11,
              bottom: 0,
              child: IntrinsicHeight(
                child: SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    color: Color(0xFFFFB72D),
                    thickness: 2,
                  ),
                ),
              )),
          Positioned(
            left: 16,
            bottom: 0,
            child: Container(
              width: 6,
              height: 6,
              decoration: const ShapeDecoration(
                color: Color(0xFFFFB72D),
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
