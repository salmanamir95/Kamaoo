import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/home_controller.dart';

class HomeViewWeb extends GetView<HomeController> {
  const HomeViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = context.theme;

    int getCrossAxisCount() {
      if (screenWidth > 1200) return 4;
      if (screenWidth > 800) return 3;
      if (screenWidth > 500) return 2;
      return 2; // Min 2 columns for web
    }

    final double padding = (screenWidth * 0.03).clamp(16.0, 48.0);
    final double gap = (screenWidth * 0.015).clamp(8.0, 16.0);

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Discover Products', style: theme.textTheme.displayMedium),
            SizedBox(height: gap * 1.5),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(strokeWidth: 1.8));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getCrossAxisCount(),
                    crossAxisSpacing: gap,
                    mainAxisSpacing: gap,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: controller.products.length,
                  itemBuilder: (_, index) => ProductItem(
                    product: controller.products[index],
                    isCompact: true,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
