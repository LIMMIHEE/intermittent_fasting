import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/domain/entities/fasting_time.dart';
import 'package:intermittent_fasting/presentation/providers/fasting_provider.dart';
import 'package:provider/provider.dart';

class FastingRatioLabel extends StatelessWidget {
  const FastingRatioLabel(
      {super.key,
      this.isFastingScreen = true,
      this.editIcon = false,
      this.ratio = ''});

  final String ratio;
  final bool isFastingScreen;
  final bool editIcon;

  @override
  Widget build(BuildContext context) {
    final fastingTime =
        context.select((FastingProvider data) => data.fastingTime);
    final title = titleText(fastingTime);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: DesignSystem.colors.appPrimary,
          width: 1,
        ),
        color: DesignSystem.colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: DesignSystem.typography.title1(TextStyle(
              color: DesignSystem.colors.appPrimary,
              fontWeight: FontWeight.w600,
            )),
          ),
          Visibility(
            visible: editIcon,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(
                Icons.edit,
                color: DesignSystem.colors.appPrimary,
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }

  String titleText(FastingTime fastingTime) {
    late String title;
    if (isFastingScreen) {
      title =
          '${fastingTime.fastingRatio} ${fastingTime.isFasting ? '단식중' : '식사중'}';
    } else {
      title = ratio;
    }

    return title;
  }
}
