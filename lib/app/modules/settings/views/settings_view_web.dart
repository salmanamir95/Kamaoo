import 'package:ecommerce_app/config/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsViewWeb extends GetView<SettingsController> {
  const SettingsViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic padding and spacing
    final horizontalPadding = (screenWidth * 0.03).clamp(16.0, 48.0);
    final verticalPadding = (screenHeight * 0.02).clamp(12.0, 32.0);
    final gap = (screenHeight * 0.015).clamp(8.0, 24.0);

    Widget buildSettingsTile({
      required String title,
      required IconData icon,
      Widget? trailing,
      VoidCallback? onTap,
    }) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: gap / 2),
        leading: Icon(icon, color: theme.iconTheme.color),
        title: Text(title,
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontSize: (screenWidth * 0.012).clamp(14, 18))),
        trailing: trailing,
        onTap: onTap,
      );
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            Text(
              'Settings',
              style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: (screenWidth * 0.02).clamp(20, 32),
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: gap * 2),

            // Settings list fills remaining vertical space
            Expanded(
              child: ListView(
                children: [
                  buildSettingsTile(
                    title: 'Dark Mode',
                    icon: Icons.dark_mode_outlined,
                    trailing: Obx(
                      () => Switch(
                        value: controller.isDarkMode.value,
                        onChanged: (value) => MyTheme.changeTheme(),
                      ),
                    ),
                    onTap: MyTheme.changeTheme,
                  ),
                  buildSettingsTile(
                    title: 'Logout',
                    icon: Icons.logout,
                    onTap: controller.onLogoutPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
