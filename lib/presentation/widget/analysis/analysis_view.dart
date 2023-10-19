import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/presentation/widget/analysis/analysis_fasting_chart.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignSystem.colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '일간 공복시간',
                      style: DesignSystem.typography.heading3(),
                    ),
                    Text(
                      '  일간 / 시간.분',
                      style: DesignSystem.typography.body2(TextStyle(
                          color: DesignSystem.colors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                    )
                  ],
                )),
            const AnalysisFastingChart()
          ],
        ),
      ),
    );
  }
}
