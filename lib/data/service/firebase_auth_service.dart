import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intermittent_fasting/core/utils/prefs_utils.dart';
import 'package:intermittent_fasting/core/utils/utils.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUpEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        PrefsUtils.setString(
            PrefsUtils.uid, _firebaseAuth.currentUser?.uid ?? "");
      });
    } on FirebaseAuthException catch (error) {
      print(error.message);
      Utils.showSnackBar(context, "${error.message}");
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _firebaseAuth.currentUser?.sendEmailVerification().then((value) {
        Utils.showSnackBar(context, '인증 메일이 전송되었습니다, 확인해주세요.');
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(context, e.message!);
    }
  }
}
