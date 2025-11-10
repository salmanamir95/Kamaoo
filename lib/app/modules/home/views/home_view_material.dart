import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/home_controller.dart';

class HomeViewMaterial extends GetView<HomeController> {
  const HomeViewMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.verticalSpace,
                  const ScreenTitle(
                    title: 'Home',
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
              }
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  mainAxisExtent: 260.h,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      ProductItem(product: controller.products[index]),
                  childCount: controller.products.length,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
