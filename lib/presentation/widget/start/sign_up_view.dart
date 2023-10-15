import 'package:flutter/material.dart';
import 'package:intermittent_fasting/presentation/widget/start/sign_up_text_field.dart';
import 'package:intermittent_fasting/presentation/widget/start/start_button.dart';

class SignUpView extends StatelessWidget {
  const SignUpView(
      {super.key,
      required this.back,
      required this.signOnTap,
      required this.emailController,
      required this.passwordController});

  final Function() back;
  final Function() signOnTap;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          child: Positioned(
              top: 60,
              left: 24,
              child: GestureDetector(
                  onTap: () => back(),
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
                  onTap: () => signOnTap(),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
