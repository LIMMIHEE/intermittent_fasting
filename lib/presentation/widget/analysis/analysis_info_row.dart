import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

class AnalysisInfoRow extends StatelessWidget {
  const AnalysisInfoRow({
    super.key,
    required this.title,
    required this.subTitle,
    required this.result,
    required this.isAchievementInfo,
  });

  final String title;
  final String subTitle;
  final String result;
  final bool isAchievementInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: DesignSystem.typography.heading4(TextStyle(
                    fontWeight: FontWeight.w600,
                    color: DesignSystem.colors.textPrimary,
                  ))),
              Text(
                subTitle,
                style: DesignSystem.typography.body2(TextStyle(
                    color: DesignSystem.colors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400)),
              )
            ],
          ),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Visibility(
                  visible: isAchievementInfo,
                  child: Container(
                    width: 70,
                    height: 16,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Config.isLightTheme()
                            ? DesignSystem.colors.appPrimary.withOpacity(0.5)
                            : DesignSystem.colors.appSecondary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                Text(result,
                    style: DesignSystem.typography.heading2(TextStyle(
                      fontWeight: FontWeight.w700,
                      color: DesignSystem.colors.textPrimary,
                    ))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
