import 'package:flutter/material.dart';

class FastingGridView extends StatelessWidget {
  const FastingGridView(
      {super.key,
      required this.fastingMap,
      required this.onTap,
      required this.selectWidget});

  final UniqueKey? selectWidget;
  final Map<UniqueKey, List<String>> fastingMap;
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
            var widgetKey = fastingMap.keys.elementAt(index);
            var isSelectWidget = selectWidget == widgetKey;
            return GestureDetector(
              onTap: () => onTap(index, widgetKey),
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
                      color: isSelectWidget
                          ? const Color(0xffFFB82E)
                          : Colors.white,
                      shape: isSelectWidget
                          ? RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )
                          : RoundedRectangleBorder(
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
                            fastingMap.values.elementAt(index).first,
                            style: TextStyle(
                              color: isSelectWidget
                                  ? Colors.white
                                  : const Color(0xFF6E777B),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              fastingMap.values.elementAt(index).last,
                              style: TextStyle(
                                color: isSelectWidget
                                    ? Colors.white
                                    : const Color(0xFF9D9D9D),
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
