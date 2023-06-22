import 'package:flutter/material.dart';
import '../Screen/StartScreen.dart';

class StartWidgetState extends State<OverlappingWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.status == "signUp") return signUpWidget();

    return welcomeWidget();
  }

  void onTap(String status) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.status = status;
      });
    });
  }

  Widget welcomeWidget(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Column(
                    children: const [
                      Text(
                        '환영합니다!',
                        style: TextStyle(
                          color: Color(0xFF392E5C),
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '단식 시작 전\n몇 가지 설정을 진행해주세요!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF9D9D9D),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Column(
              children: [
                StartButton(
                  childWidget: const Text(
                    '앱으로만 사용할래요',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => onTap("fastingSet"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: StartButton(
                    childWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '웹으로도 사용할래요',
                          style: TextStyle(
                            color: Color(0xFF392E5C),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '회원가입이 필요합니다',
                          style: TextStyle(
                            color: Color(0xFF9D9D9D),
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    isOutlineWidget: true,
                    onTap: () => onTap("signUp"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget signUpWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        color: Color(0xFF392E5C),
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SignUpTextField(
                    hintText: '메일주소',
                    icon: Icons.mail_outline_rounded,
                  ),
                  SignUpTextField(
                    hintText: '비밀번호',
                    icon: Icons.vpn_key_outlined,
                  ),
                ],
              ),
            )),
            StartButton(
              childWidget: const Text(
                '가입하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

class SignUpTextField extends StatelessWidget {
  const SignUpTextField(
      {super.key, required this.hintText, required this.icon});

  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38, vertical: 9),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF392E5C)),
          borderRadius: BorderRadius.circular(49),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF392E5C),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: Color(0xFF9D9D9D),
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton(
      {super.key,
      required this.childWidget,
      required this.onTap,
      this.isOutlineWidget = false});

  final Widget childWidget;
  final Function onTap;
  final bool isOutlineWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          height: 72,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 39),
          decoration: ShapeDecoration(
              color: isOutlineWidget ? Colors.white : const Color(0xFF392E5C),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: isOutlineWidget ? 1 : 0,
                    color: const Color(0xFF392E5C)),
                borderRadius: BorderRadius.circular(49),
              )),
          child: childWidget),
    );
  }
}
