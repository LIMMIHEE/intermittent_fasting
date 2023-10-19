import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/presentation/screen/fasting_rate_screen.dart';
import 'package:intermittent_fasting/presentation/widget/common/custom_path.dart';
import 'package:intermittent_fasting/presentation/widget/common/fasting_ratio_label.dart';
import 'package:intermittent_fasting/presentation/widget/home/home_timer_circle_progress.dart';

class HomeTimerView extends StatelessWidget {
  const HomeTimerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          top: 0,
          child: ClipPath(
            clipper: CustomPath(),
            child: Container(
              decoration: BoxDecoration(
                color: DesignSystem.colors.appPrimary.withOpacity(0.2),
              ),
              width: 300,
              height: 140,
            ),
          ),
        ),
        Positioned(
          top: 110,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const FastingRateScreen(comeStartScreen: false)));
            },
            child: const FastingRatioLabel(editIcon: true),
          ),
        ),
        const HomeTimerCircleProgress(),
      ],
    );
  }
}
