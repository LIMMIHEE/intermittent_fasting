import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

class HistorySheetButton extends StatelessWidget {
  const HistorySheetButton(
      {super.key, required this.onTap, this.isDeleteButton = false});

  final Function() onTap;
  final bool isDeleteButton;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: isDeleteButton
                  ? DesignSystem.colors.deleteRed
                  : DesignSystem.colors.saveYellow,
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Text(
              isDeleteButton ? '기록 삭제' : '저장 및 닫기',
              style: DesignSystem.typography.title1(TextStyle(
                color: DesignSystem.colors.white,
                fontWeight: FontWeight.w600,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
