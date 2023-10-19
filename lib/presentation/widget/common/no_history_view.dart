import 'package:flutter/material.dart';

class NoHistoryView extends StatelessWidget {
  const NoHistoryView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '아직 기록 사항이 없습니다!',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
