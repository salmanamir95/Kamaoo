import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import 'product_image.dart';
import '../../../components/custom_button.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsViewWeb extends GetView<ProductDetailsController> {
  const ProductDetailsViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamic padding and gap calculations
    final double padding = (screenWidth * 0.03).clamp(16.0, 48.0);
    final double gap = (screenWidth * 0.015).clamp(8.0, 24.0);

    Widget buildRating() => Row(
          children: [
            const Icon(Icons.star_rounded, color: Color(0xFFFFC542)),
            SizedBox(width: gap / 2),
            Text(controller.product.rating.toString(),
                style: theme.textTheme.bodyLarge),
            SizedBox(width: gap / 2),
            Text('(${controller.product.reviews} reviews)',
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
          ],
        );

    Widget buildDescription() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: gap),
            Text(
              'This is a placeholder for the product description. More details about this amazing product will be shown here. It is made of high-quality materials and is designed to last.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        );

    Widget buildActions() => Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Add to Cart',
                onPressed: controller.onAddToCartPressed,
              ),
            ),
            SizedBox(width: gap),
            GetBuilder<ProductDetailsController>(
              id: 'FavoriteButton',
              builder: (_) => IconButton(
                onPressed: controller.onFavoriteButtonPressed,
                icon: SvgPicture.asset(
                  controller.product.isFavorite
                      ? Constants.favFilledIcon
                      : Constants.favOutlinedIcon,
                  colorFilter: ColorFilter.mode(
                    controller.product.isFavorite
                        ? const Color(0xFFFF0000)
                        : theme.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                iconSize: (screenWidth * 0.025).clamp(28.0, 40.0),
              ),
            ),
          ],
        );

    Widget buildProductImage() => AspectRatio(
          aspectRatio: 1.0, // Make the image container square
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEDF1FA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: ProductImage(
                image: controller.product.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );

    Widget buildProductDetails() => SingleChildScrollView(
          // SingleChildScrollView does not have primary or shrinkWrap parameters
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.product.name,
                  style: theme.textTheme.displayMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: gap / 2), // Slightly reduce spacing
              buildRating(),
              SizedBox(height: gap * 1.5),
              Text('\$${controller.product.price}',
                  style: theme.textTheme.displayLarge
                      ?.copyWith(color: theme.primaryColor)),
              SizedBox(height: gap * 1.5),
              const Divider(),
              SizedBox(height: gap * 1.5),
              buildDescription(),
              SizedBox(height: gap * 2),
              buildActions(),
            ],
          ),
        );

    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      // Use a two-column layout for wider screens
      if (constraints.maxWidth > 800) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: buildProductImage()),
              SizedBox(width: padding),
              Expanded(flex: 2, child: buildProductDetails()),
            ],
          ),
        );
      }

      // Use a single-column layout for narrower screens
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProductImage(), // Now returns an AspectRatio widget
            SizedBox(height: padding),
            buildProductDetails(),
          ],
        ),
      );
    }));
  }
}
