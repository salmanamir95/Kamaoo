import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../../../data/models/product_model.dart';
import '../../controllers/cart_controller.dart';
import '../../../product_details/views/product_image.dart';

class CartItem extends GetView<CartController> {
  final ProductModel product;
  const CartItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return LayoutBuilder(builder: (context, constraints) {
      final double imageContainerWidth = constraints.maxWidth * 0.25;
      final double imageContainerHeight = imageContainerWidth * 1.2;
      final double gap = constraints.maxWidth * 0.04;

      return Padding(
        padding: EdgeInsets.only(bottom: gap),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: imageContainerWidth,
              height: imageContainerHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: const Color(0xFFEDF1FA),
                    ),
                    ProductImage(
                      image: product.image,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: gap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: gap / 4),
                  Text('Size: ${product.size}',
                      style: theme.textTheme.bodySmall),
                  SizedBox(height: gap / 4),
                  Text(
                    'Rs${product.price}',
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: gap / 2),
                  Obx(
                    () => Row(
                      children: [
                        _buildQuantityButton(
                          icon: Constants.decreaseIcon,
                          onTap: controller.isLoading
                              ? null
                              : () => controller.onDecreasePressed(product.id),
                        ),
                        SizedBox(width: gap / 2),
                        Text('${product.quantity}',
                            style: theme.textTheme.bodyMedium),
                        SizedBox(width: gap / 2),
                        _buildQuantityButton(
                          icon: Constants.increaseIcon,
                          onTap: controller.isLoading
                              ? null
                              : () => controller.onIncreasePressed(product.id),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: controller.isLoading
                  ? null
                  : () => controller.onDeletePressed(product.id),
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  Constants.cancelIcon,
                  width: 18,
                  height: 18,
                  colorFilter: ColorFilter.mode(
                      theme.textTheme.bodyMedium!.color!, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildQuantityButton(
      {required String icon, required VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(icon,
          width: 24,
          height: 24,
          colorFilter: onTap == null
              ? const ColorFilter.mode(Colors.grey, BlendMode.srcIn)
              : null),
    );
  }
}
