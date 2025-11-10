import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/product_item.dart';
import '../controllers/home_controller.dart';

class HomeViewCupertino extends GetView<HomeController> {
  const HomeViewCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Obx(
        () => CustomScrollView(
          slivers: [
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Home'),
            ),
            if (controller.isLoading.value)
              const SliverFillRemaining(
                child: Center(child: CupertinoActivityIndicator()),
              )
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    mainAxisExtent: 260.h,
                  ),
                  delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          ProductItem(product: controller.products[index]),
                      childCount: controller.products.length),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
