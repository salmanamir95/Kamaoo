import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isDark;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    this.isDark = false,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
      ),
      leading: CircleAvatar(
        radius: 25.r,
        backgroundColor: theme.primaryColor,
        child: SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          width: 22.w,
        ),
      ),
      trailing: trailing ??
          (isDark
              ? Obx(
                  () => CupertinoSwitch(
                      value: Get.isDarkMode,
                      onChanged: (value) => Get.changeTheme(Get.isDarkMode
                          ? ThemeData.light()
                          : ThemeData.dark())),
                )
              : SvgPicture.asset(
                  Constants.forwardArrowIcon,
                  colorFilter: ColorFilter.mode(
                      theme.textTheme.bodyLarge?.color ?? Colors.grey,
                      BlendMode.srcIn),
                  width: 20.w,
                )),
    );
  }
}
