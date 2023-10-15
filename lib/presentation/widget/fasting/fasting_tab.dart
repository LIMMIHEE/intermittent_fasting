import 'package:flutter/material.dart';

class FastingTab extends StatelessWidget {
  const FastingTab(
      {super.key,
      required TabController tabController,
      required this.title,
      required this.index})
      : _tabController = tabController;

  final TabController _tabController;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Stack(
        children: [
          Visibility(
            visible: _tabController.index == index,
            child: Positioned(
              bottom: 12,
              child: Container(
                width: 64,
                height: 15,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
              visible: _tabController.index == index,
              child: Positioned(
                bottom: 0,
                child: Container(
                  width: 63,
                  height: 4,
                  decoration: BoxDecoration(
                      color: const Color(0xBF392E5C),
                      borderRadius: BorderRadius.circular(16)),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF392E5C),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
