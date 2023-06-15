import 'package:flutter/material.dart';

class ButtonTab extends StatelessWidget {
  const ButtonTab({super.key, required this.widgetChild});

  final List<Widget> widgetChild;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 19),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ...widgetChild,
                  Padding(
                    padding:
                    EdgeInsets.only(top: widgetChild.isNotEmpty ? 15 : 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonTabItem(
                          icon: Icons.timer,
                          title: "단식",
                        ),
                        ButtonTabItem(
                          icon: Icons.sticky_note_2,
                          title: "기록",
                        ),
                        ButtonTabItem(
                          icon: Icons.insert_chart_rounded,
                          title: "분석",
                        ),
                        ButtonTabItem(
                          icon: Icons.settings,
                          title: "설정",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 186,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    width: 110,
                    height: 45,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffFFB82E),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffFFB82E).withOpacity(0.2),
                          blurRadius: 3,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "종료",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.pause,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class ButtonTabItem extends StatelessWidget {
  const ButtonTabItem({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(title),
        )
      ],
    );
  }
}
