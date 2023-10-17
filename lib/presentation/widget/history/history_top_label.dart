import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:provider/provider.dart';

class HistoryTopLabel extends StatelessWidget {
  const HistoryTopLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fastingState =
        context.select((FastingProvider data) => data.fastingTime).isFasting;

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
