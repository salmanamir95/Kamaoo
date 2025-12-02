import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../data/models/product_model.dart';
import '../modules/base/controllers/base_controller.dart';
import '../routes/app_pages.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final bool isCompact;
  const ProductItem({
    super.key,
    required this.product,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: isCompact ? 150 : 200.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF1FA),
                      borderRadius:
                          BorderRadius.circular(isCompact ? 16 : 25.r),
                    ),
                  ),
                  Positioned(
                    right: isCompact ? 10 : (product.id == 2 ? 0 : 20.w),
                    bottom: -80.h,
                    child: _buildProductImage(),
                  ),
                  Positioned(
                    left: 15.w,
                    bottom: 20.h,
                    child: GetBuilder<BaseController>(
                      id: 'FavoriteButton',
                      builder: (controller) => GestureDetector(
                        onTap: () => controller.onFavoriteButtonPressed(
                            product: product),
                        child: CircleAvatar(
                          radius: isCompact ? 16 : 18.r,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(
                            product.isFavorite
                                ? Constants.favFilledIcon
                                : Constants.favOutlinedIcon,
                            color:
                                product.isFavorite ? null : theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ).animate().fade(),
                ],
              ),
              isCompact ? const SizedBox(height: 8) : 10.verticalSpace,
              Text(
                product.name,
                style: isCompact
                    ? theme.textTheme.bodySmall
                    : theme.textTheme.bodyMedium,
              ).animate().fade().slideY(
                    duration: const Duration(milliseconds: 200),
                    begin: 1,
                    curve: Curves.easeInSine,
                  ),
              isCompact ? const SizedBox(height: 4) : 5.verticalSpace,
              Text(
                'Rs${product.price}',
                style: isCompact
                    ? theme.textTheme.bodyLarge
                    : theme.textTheme.displaySmall,
              ).animate().fade().slideY(
                    duration: const Duration(milliseconds: 200),
                    begin: 2,
                    curve: Curves.easeInSine,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    try {
      final imageBytes = base64Decode(product.image);
      return Image.memory(imageBytes, height: isCompact ? 220 : 260.h)
          .animate()
          .slideX(
            duration: const Duration(milliseconds: 200),
            begin: 1,
            curve: Curves.easeInSine,
          );
    } catch (e) {
      return Image.asset('assets/images/no_data.png',
              height: isCompact ? 220 : 260.h)
          .animate()
          .slideX(
            duration: const Duration(milliseconds: 200),
            begin: 1,
            curve: Curves.easeInSine,
          );
    }
  }
}
