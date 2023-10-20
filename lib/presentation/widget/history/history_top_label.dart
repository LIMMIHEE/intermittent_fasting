import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
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
        DesignSystem.colors.appPrimary.withOpacity(0.3),
        DesignSystem.colors.backgroundWhite,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: ShapeDecoration(
              color: DesignSystem.colors.appPrimary,
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
                      style: DesignSystem.typography.heading3(TextStyle(
                        color: DesignSystem.colors.white,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 11,
              bottom: 0,
              child: IntrinsicHeight(
                child: SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    color: DesignSystem.colors.appPrimary,
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
              decoration: ShapeDecoration(
                color: DesignSystem.colors.appPrimary,
                shape: const OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
