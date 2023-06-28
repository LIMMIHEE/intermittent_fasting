import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intermittent_fasting/Screen/fasting_rate_screen.dart';
import 'package:intermittent_fasting/widget/start_widget.dart';
import 'package:jelly_anim/jelly_anim.dart';

import '../Service/firebase_auth_service.dart';
import '../Utils/utils.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          JellyAnim(
              jellyCount: 1,
              radius: 90,
              viewPortSize: const Size(900, 600),
              jellyCoordinates: 4,
              allowOverFlow: true,
              duration: const Duration(minutes: 1),
              colors: const [Color(0xffFFF1D5)],
              jellyPosition: JellyPosition.topLeft),
          JellyAnim(
              jellyCount: 1,
              radius: 330,
              viewPortSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height + 200),
              jellyCoordinates: 12,
              allowOverFlow: true,
              duration: const Duration(minutes: 1),
              colors: const [Color(0xffFFF1D5)],
              jellyPosition: JellyPosition.bottomCenter),
          OverlappingWidget(),
        ],
      ),
    );
  }
}

class OverlappingWidget extends StatefulWidget {
  OverlappingWidget({super.key});

  var status = "welecome";

  @override
  State<OverlappingWidget> createState() => StartWidgetState();
}

class StartWidgetState extends State<OverlappingWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.status == "signUp") return signUpWidget();

    return welcomeWidget();
  }

  void onTap(String status) {
    if (status == "fastingSet") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const FastingRateScreen(comeStartScreen: true)));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.status = status;
      });
    });
  }

  Widget welcomeWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 120),
              child: Column(
                children: [
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
                    childWidget: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
    return Stack(
      children: [
        Visibility(
          child: Positioned(
              top: 60,
              left: 24,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.status = "welecome";
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 28,
                    color: Color(0xFF392E5C),
                  ))),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Column(
                    children: [
                      const Padding(
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
                        controller: emailController,
                      ),
                      SignUpTextField(
                        hintText: '비밀번호',
                        icon: Icons.vpn_key_outlined,
                        controller: passwordController,
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
                  onTap: () {
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(emailController.text)) {
                      Utils().showSnackBar(context, "정확한 이메일을 입력해주세요!");
                      return;
                    }

                    if (passwordController.text.length < 6) {
                      Utils().showSnackBar(context, "비밀번호를 6글자 이상 설정해주세요!");
                      return;
                    }

                    FirebaseAuthService()
                        .signUpEmail(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context)
                        .then((value) {
                      onTap("fastingSet");
                    });
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
