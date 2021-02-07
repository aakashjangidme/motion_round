import 'package:flutter/material.dart';
import 'package:machine_round_task/src/ui/widgets/custom_flat_button.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/services/device_info/device_info.dart';
import '../../core/theme/theme_notifier.dart';

import '../../locator.dart';
import '../widgets/margins.dart';
import 'settings_tile.dart';

class Settings extends StatelessWidget {
  final DeviceInfoService _deviceInfo = locator<DeviceInfoService>();
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);
    var theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YMargin(32),
            SettingsTile(
              settingName: 'Account',
              items: [
                SettingsItem(
                  title: prov.userDetails.name,
                  subtitle: prov.userDetails.email,
                )
              ],
            ),
            SettingsTile(
              settingName: 'Device',
              items: [
                SettingsItem(
                  title: _deviceInfo.device,
                  trailing: null,
                )
              ],
            ),
            Consumer<ThemeNotifier>(
              builder: (_, _themeNotifier, __) => SettingsTile(
                settingName: 'App Settings',
                items: [
                  SettingsItem(
                    title: 'DarkTheme',
                    trailing: Switch(
                      activeColor: theme.accentColor,
                      value: _themeNotifier.darkMode,
                      onChanged: (val) =>
                          context.read<ThemeNotifier>().darkMode = val,
                    ),
                  )
                ],
              ),
            ),
            YMargin(8),
            Spacer(),
            CustomFlatButton(
              onPressed: () async {
                await context.read<AuthProvider>().signOut();
              },
              buttonText: 'LOGOUT',
            ),
          ],
        ),
      ),
    );
  }
}
