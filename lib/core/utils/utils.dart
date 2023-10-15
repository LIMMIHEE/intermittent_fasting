import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 2000),
      backgroundColor: const Color(0xFF392E5C),
      content: Text(text),
    ));
  }

  Future<String> getDeviceUniqueId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;

    final deviceId = Platform.isAndroid
        ? allInfo["androidId"]
        : allInfo["identifierForVendor"];

    return deviceId;
  }
}
