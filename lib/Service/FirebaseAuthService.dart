import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intermittent_fasting/Utils/Globals.dart';

import '../Utils/Prefs.dart';
import '../Utils/Utils.dart';

class FirebaseAuthService {
  final utils = Utils();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUpEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        prefs?.setString(Prefs().UID, _firebaseAuth.currentUser?.uid ?? "");
      });
    } on FirebaseAuthException catch (error) {
      print(error.message);
      utils.showSnackBar(context, "${error.message}");
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _firebaseAuth.currentUser?.sendEmailVerification().then((value) {
        utils.showSnackBar(context, '인증 메일이 전송되었습니다, 확인해주세요.');
      });
    } on FirebaseAuthException catch (e) {
      utils.showSnackBar(context, e.message!);
    }
  }
}
