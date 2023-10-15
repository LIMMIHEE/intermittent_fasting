import 'package:flutter/material.dart';
import 'package:intermittent_fasting/presentation/widget/start/start_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key, required this.onTap});

  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
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
    ;
  }
}
