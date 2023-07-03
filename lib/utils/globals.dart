import 'package:intermittent_fasting/model/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
late List<History> historyList;

bool isLogin = false;
