import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

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
                    color: DesignSystem.colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: [
                      BoxShadow(
                        color: DesignSystem.colors.shadow,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: isSelectWidget
                          ? DesignSystem.colors.appPrimary
                          : DesignSystem.colors.white,
                      shape: isSelectWidget
                          ? RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )
                          : RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1,
                                  color: DesignSystem.colors.blueGray),
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
                                  ? DesignSystem.colors.white
                                  : DesignSystem.colors.blueGray,
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
                                    ? DesignSystem.colors.white
                                    : DesignSystem.colors.gray700,
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
