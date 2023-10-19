import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 2000),
      backgroundColor: DesignSystem.colors.appSecondary,
      content: Text(text),
    ));
  }

  static void showDeleteDialog(BuildContext context, Function() onDelete) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '기록을 삭제하시겠습니까?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: Text('삭제 후 되돌릴 수 없습니다!'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                '삭제',
                style: TextStyle(color: DesignSystem.colors.deleteRed),
              ),
              onPressed: () {
                onDelete();
              },
            ),
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
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
