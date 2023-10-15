import 'package:flutter/material.dart';

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
