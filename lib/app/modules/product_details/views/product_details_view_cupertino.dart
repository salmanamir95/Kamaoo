import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'product_image.dart';
import '../../../../utils/constants.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsViewCupertino extends GetView<ProductDetailsController> {
  const ProductDetailsViewCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(controller.product.name),
            trailing: GetBuilder<ProductDetailsController>(
              id: 'FavoriteButton',
              builder: (_) => CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => controller.onFavoriteButtonPressed(),
                child: SvgPicture.asset(
                  controller.product.isFavorite
                      ? Constants.favFilledIcon
                      : Constants.favOutlinedIcon,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 280.h,
                  width: double.infinity,
                  color: const Color(0xFFEDF1FA),
                  child: ProductImage(
                    image: controller.product.image,
                    height: 280.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.product.name,
                            style: theme.textTheme.displayMedium
                                ?.copyWith(fontSize: 20.sp),
                          ),
                          Text(
                            '\Rs${controller.product.price}',
                            style: theme.textTheme.displayMedium
                                ?.copyWith(fontSize: 20.sp),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          const Icon(CupertinoIcons.star_fill,
                              color: CupertinoColors.systemYellow),
                          5.horizontalSpace,
                          Text(
                            controller.product.rating.toString(),
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontSize: 16.sp),
                          ),
                          5.horizontalSpace,
                          Text(
                            '(${controller.product.reviews} Reviews)',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      15.verticalSpace,
                      // Placeholder for description
                      Text(
                        'This is a placeholder for the product description. More details about this amazing product will be shown here.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    child: const Text('Add to Cart'),
                    onPressed: () => controller.onAddToCartPressed(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
