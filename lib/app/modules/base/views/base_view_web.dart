import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/base_controller.dart';

class BaseViewWeb extends GetView<BaseController> {
  const BaseViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 80,
            child: Obx(
              () => NavigationRail(
                selectedIndex: controller.currentIndex.value,
                onDestinationSelected: controller.changeScreen,
                labelType: NavigationRailLabelType.selected,
                extended: false,
                minWidth: 40,
                destinations: [
                  for (int i = 0; i < controller.pages.length; i++)
                    NavigationRailDestination(
                      icon: SvgPicture.asset(
                        controller.bottomNavBarIcons[i],
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                            theme.iconTheme.color!, BlendMode.srcIn),
                      ),
                      selectedIcon: SvgPicture.asset(
                        controller.bottomNavBarIcons[i],
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                            theme.primaryColor, BlendMode.srcIn),
                      ),
                      label: Text(
                        controller.bottomNavBarLabels[i],
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Center and constrain main content
          Expanded(
            // Let the child pages control their own layout
            child: Obx(() => controller.pages[controller.currentIndex.value]),
          ),
        ],
      ),
    );
  }
}
