import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/no_data.dart';
import '../../../components/product_item.dart';
import '../controllers/favorites_controller.dart';

class FavoritesViewCupertino extends GetView<FavoritesController> {
  const FavoritesViewCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Favorites'),
      ),
      child: SafeArea(
        child: Obx(
          () {
            if (controller.products.isEmpty) {
              return const Center(
                  child: NoData(text: 'No Products in Favorite Yet!'));
            }
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                mainAxisExtent: 260.h,
              ),
              shrinkWrap: true,
              primary: false,
              itemCount: controller.products.length,
              itemBuilder: (context, index) => ProductItem(
                product: controller.products[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
