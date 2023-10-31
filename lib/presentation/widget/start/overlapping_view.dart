import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/utils/prefs_utils.dart';
import 'package:intermittent_fasting/core/utils/utils.dart';
import 'package:intermittent_fasting/data/service/firebase_auth_service.dart';
import 'package:intermittent_fasting/presentation/screen/fasting_rate_screen.dart';
import 'package:intermittent_fasting/presentation/widget/start/sign_up_view.dart';
import 'package:intermittent_fasting/presentation/widget/start/welcome_view.dart';

class OverlappingView extends StatefulWidget {
  OverlappingView({super.key});

  var status = "welecome";

  @override
  State<OverlappingView> createState() => OverlappingViewState();
}

class OverlappingViewState extends State<OverlappingView> {
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
        PrefsUtils.setString(PrefsUtils.uid, value);
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
