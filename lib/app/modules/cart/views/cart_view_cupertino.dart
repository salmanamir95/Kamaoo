import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/no_data.dart';
import '../controllers/cart_controller.dart';
import 'widgets/cart_item.dart';

class CartViewCupertino extends GetView<CartController> {
  const CartViewCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cart'),
      ),
      child: SafeArea(
        child: Obx(
          () {
            if (controller.products.isEmpty) {
              return const Center(
                  child: NoData(text: 'No Products in Your Cart Yet!'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CartItem(
                        product: controller.products[index],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:', style: theme.textTheme.bodyLarge),
                          Text(
                            '\Rs${controller.total.toStringAsFixed(2)}',
                            style: theme.textTheme.displayLarge,
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.filled(
                          child: const Text('Purchase Now'),
                          onPressed: () => controller.onPurchaseNowPressed(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
