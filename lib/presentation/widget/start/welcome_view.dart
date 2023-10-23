import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
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
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 120),
              child: Column(
                children: [
                  Text(
                    '환영합니다!',
                    style: DesignSystem.typography.display2(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '단식 시작 전\n몇 가지 설정을 진행해주세요!',
                      textAlign: TextAlign.center,
                      style: DesignSystem.typography.title3(TextStyle(
                        color: DesignSystem.colors.gray700,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                  ),
                ],
              ),
            )),
            Column(
              children: [
                StartButton(
                  childWidget: Text(
                    '앱으로만 사용할래요',
                    style: DesignSystem.typography.body(TextStyle(
                      color: DesignSystem.colors.white,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                  onTap: () => onTap("fastingSet"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: StartButton(
                    childWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '웹으로도 사용할래요',
                          style: DesignSystem.typography.body(),
                        ),
                        Text(
                          '회원가입이 필요합니다',
                          style: DesignSystem.typography.caption1(TextStyle(
                            color: DesignSystem.colors.gray700,
                            fontWeight: FontWeight.w400,
                          )),
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
