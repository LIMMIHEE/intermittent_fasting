import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/utils/prefs_utils.dart';
import 'package:intermittent_fasting/core/utils/utils.dart';
import 'package:intermittent_fasting/data/service/firebase_auth_service.dart';
import 'package:intermittent_fasting/presentation/screen/fasting_rate_screen.dart';
import 'package:intermittent_fasting/presentation/widget/start/sign_up_view.dart';
import 'package:intermittent_fasting/presentation/widget/start/welcome_view.dart';
import 'package:jelly_anim/jelly_anim.dart';

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
    if (widget.status == "signUp") {
      return SignUpView(
        back: onBack,
        signOnTap: signOnTap,
        emailController: emailController,
        passwordController: passwordController,
      );
    }

    return WelcomeView(
      onTap: onTap,
    );
  }

  void onBack() {
    setState(() {
      widget.status = "welecome";
    });
  }

  void signOnTap() {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      Utils.showSnackBar(context, "정확한 이메일을 입력해주세요!");
      return;
    }

    if (passwordController.text.length < 6) {
      Utils.showSnackBar(context, "비밀번호를 6글자 이상 설정해주세요!");
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
  }

  void onTap(String status) {
    if (status == "fastingSet") {
      Utils().getDeviceUniqueId().then((value) {
        PrefsUtils.setString(PrefsUtils.prefs.uid, value);
      });

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
}
