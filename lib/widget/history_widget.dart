import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermittent_fasting/widget/common_widget.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 45, bottom: 20),
            child: Text(
              '총 120일간\n진행 하였습니다.',
              style: TextStyle(
                color: Color(0xFF392E5C),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          HistoryTopLabel(),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return HistoryBottomSheet();
                    },
                  );
                },
                child: HistoryListItem(),
              );
            },
          )
        ],
      ),
    );
  }
}

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              FastingRatioLabel(isFastingScreen: false),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "6/10 오후 6 : 26",
                      style: const TextStyle(
                        color: Color(0xff9d9d9d),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "6/11  오전 4 : 26",
                      style: const TextStyle(
                        color: Color(0xff9d9d9d),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '16시간 25분',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Color(0xff9D9D9D),
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}

class HistoryBottomSheet extends StatelessWidget {
  const HistoryBottomSheet({super.key});

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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
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
                  '오늘 식단은 클린하지 못한 것 같다... 묘하게 자극적인 음식을 많이 먹은 듯...ㅠㅠ \n\n내일은 더 클린하게 먹도록 노력하기!!',
                  style: TextStyle(
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
                  ),
                  Expanded(
                    child: Text(
                      '총 16시간 25분',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(
                      '6/10 오후 6 : 26',
                      style: TextStyle(
                        color: Color(0xFF9D9D9D),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/images/icon_time_arrow.png',
                        width: 35,
                        height: 35,
                      ),
                    ),
                    Text(
                      '6/10 오후 6 : 26',
                      style: TextStyle(
                        color: Color(0xFF9D9D9D),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
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
                      onTap: () {},
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
                  'assets/images/icon_smile.svg',
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      '단식 중',
                      style: TextStyle(
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
