import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/base_controller.dart';

class BaseViewMaterial extends GetView<BaseController> {
  const BaseViewMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeScreen,
          items: [
            for (int i = 0; i < controller.pages.length; i++)
              BottomNavigationBarItem(
                icon: SvgPicture.asset(controller.bottomNavBarIcons[i]),
                label: controller.bottomNavBarLabels[i],
                activeIcon: SvgPicture.asset(
                  controller.bottomNavBarIcons[i],
                  colorFilter: ColorFilter.mode(
                      context.theme.primaryColor, BlendMode.srcIn),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
