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

class FastingGridView extends StatelessWidget {
  const FastingGridView(
      {super.key, required this.fastingMap, required this.onTap});

  final Map fastingMap;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: GridView.builder(
          padding: const EdgeInsets.only(top: 23),
          itemCount: fastingMap.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5 / 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFF6E777B)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            fastingMap.keys.elementAt(index),
                            style: const TextStyle(
                              color: Color(0xFF6E777B),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              fastingMap.values.elementAt(index),
                              style: const TextStyle(
                                color: Color(0xFF9D9D9D),
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            );
          }),
    );
  }
}
