import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

class NoHistoryView extends StatelessWidget {
  const NoHistoryView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('아직 기록 사항이 없습니다!',
          style: DesignSystem.typography.body2(
            TextStyle(
                color: DesignSystem.colors.textSecondary,
                fontWeight: FontWeight.w400),
          )),
    );
  }
}
