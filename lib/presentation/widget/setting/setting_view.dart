import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intermittent_fasting/core/config/design_system/design_system.dart';
import 'package:intermittent_fasting/core/utils/utils.dart';
import 'package:intermittent_fasting/presentation/providers/setting_provider.dart';
import 'package:intermittent_fasting/presentation/screen/start_screen.dart';
import 'package:intermittent_fasting/presentation/widget/common/accumulated_date_text.dart';
import 'package:intermittent_fasting/presentation/widget/setting/setting_row.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        context.select((SettingProvider data) => data.isDarkMode);
    return Scaffold(
      backgroundColor: DesignSystem.colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AccumulatedDateText(),
          SettingRow(
            children: [
              const Expanded(
                child: Text(
                  '다크모드',
                ),
              ),
              Transform.scale(
                scale: 0.85,
                child: CupertinoSwitch(
                  activeColor: DesignSystem.colors.black,
                  value: isDarkMode,
                  onChanged: (value) {
                    context.read<SettingProvider>().changeTheme(value);
                  },
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              launchUrl(Uri.parse('https://forms.gle/RewNYJtwaZNuPZkH9'));
            },
            child: SettingRow(
              isLast: true,
              children: [
                const Expanded(
                  child: Text(
                    '의견 보내기',
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: DesignSystem.colors.gray700,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 72,
          ),
          SettingRow(
            children: [
              GestureDetector(
                onTap: () {
                  Utils.showDeleteDialog(context, () {
                    context.read<SettingProvider>().allDataClear(() {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartScreen()),
                          (route) => false);
                    });
                  });
                },
                child: Text(
                  '모든 데이터 삭제하기',
                  style: TextStyle(color: DesignSystem.colors.deleteRed),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
