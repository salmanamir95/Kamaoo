import 'package:ecommerce_app/config/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../controllers/settings_controller.dart';

class SettingsViewMaterial extends GetView<SettingsController> {
  const SettingsViewMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic padding and spacing
    final horizontalPadding = (screenWidth * 0.05).clamp(16.0, 32.0);
    final verticalPadding = (screenHeight * 0.02).clamp(12.0, 24.0);
    final itemGap = (screenHeight * 0.02).clamp(10.0, 20.0);

    Widget buildSettingsTile({
      required String title,
      required IconData icon,
      Widget? trailing,
      VoidCallback? onTap,
    }) {
      return ListTile(
        leading: Icon(icon, color: theme.iconTheme.color),
        title: Text(title, style: theme.textTheme.bodyMedium),
        trailing: trailing,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                'Settings',
                style: theme.textTheme.displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: itemGap),
            buildSettingsTile(
              title: 'My Account',
              icon: Icons.person_outline,
              onTap: () {},
            ),
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
    );
  }
}
