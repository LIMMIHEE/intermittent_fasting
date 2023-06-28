import 'package:firebase_core/firebase_core.dart';
import 'package:intermittent_fasting/firebase_options.dart';

class FirebaseUtils {
  void firebaseSetting() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
