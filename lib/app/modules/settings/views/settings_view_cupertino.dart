import 'package:ecommerce_app/app/modules/settings/controllers/settings_controller.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingsViewCupertino extends GetView<SettingsController> {
  const SettingsViewCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile.notched(
                  title: const Text('My Account'),
                  leading: SvgPicture.asset(Constants.userIcon,
                      colorFilter: const ColorFilter.mode(
                          CupertinoColors.label, BlendMode.srcIn)),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () {},
                ),
                CupertinoListTile.notched(
                  title: const Text('Dark Mode'),
                  leading: SvgPicture.asset(Constants.themeIcon,
                      colorFilter: const ColorFilter.mode(
                          CupertinoColors.label, BlendMode.srcIn)),
                  trailing: Obx(
                    () => CupertinoSwitch(
                      value: controller.isDarkMode.value,
                      onChanged: (value) => controller.onChangeThemePressed(),
                    ),
                  ),
                ),
                CupertinoListTile.notched(
                  title: const Text('Language'),
                  leading: SvgPicture.asset(Constants.languageIcon,
                      colorFilter: const ColorFilter.mode(
                          CupertinoColors.label, BlendMode.srcIn)),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () {},
                ),
                CupertinoListTile.notched(
                  title: const Text('Help Center'),
                  leading: SvgPicture.asset(Constants.helpIcon,
                      colorFilter: const ColorFilter.mode(
                          CupertinoColors.label, BlendMode.srcIn)),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () {},
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile.notched(
                  title: const Text('Logout',
                      style: TextStyle(color: CupertinoColors.destructiveRed)),
                  leading: SvgPicture.asset(Constants.logoutIcon,
                      colorFilter: const ColorFilter.mode(
                          CupertinoColors.destructiveRed, BlendMode.srcIn)),
                  onTap: () => controller.onLogoutPressed(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
