import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/base_controller.dart';

class BaseViewCupertino extends GetView<BaseController> {
  const BaseViewCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            for (int i = 0; i < controller.pages.length; i++)
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  controller.bottomNavBarIcons[i],
                  colorFilter: i == controller.currentIndex.value
                      ? ColorFilter.mode(
                          context.theme.primaryColor, BlendMode.srcIn)
                      : const ColorFilter.mode(
                          CupertinoColors.inactiveGray, BlendMode.srcIn),
                ),
                label: controller.bottomNavBarLabels[i],
              ),
          ],
          onTap: controller.changeScreen,
          currentIndex: controller.currentIndex.value,
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return controller.pages[index];
            },
          );
        },
      ),
    );
  }
}
