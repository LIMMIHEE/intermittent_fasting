import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

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
                  color: DesignSystem.colors.white,
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
                      color: DesignSystem.colors.appSecondary,
                      borderRadius: BorderRadius.circular(16)),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              title,
              style: DesignSystem.typography.title1(),
            ),
          ),
        ],
      ),
    );
  }
}
