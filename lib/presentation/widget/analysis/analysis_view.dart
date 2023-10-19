import 'package:flutter/material.dart';
import 'package:intermittent_fasting/presentation/widget/analysis/analysis_fasting_chart.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '일간 공복시간',
                      style: TextStyle(
                        color: Color(0xFF392E5C),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '  일간 / 시간.분',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    )
                  ],
                )),
            AnalysisFastingChart()
          ],
        ),
      ),
    );
  }
}
