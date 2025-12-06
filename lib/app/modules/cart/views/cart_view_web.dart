import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../components/custom_button.dart';
import '../../../components/no_data.dart';
import '../controllers/cart_controller.dart';
import 'widgets/cart_item.dart';

class CartViewWeb extends GetView<CartController> {
  const CartViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final screenWidth = MediaQuery.of(context).size.width;

    final double padding = (screenWidth * 0.03).clamp(16.0, 48.0);
    final double gap = (screenWidth * 0.015).clamp(8.0, 16.0);

    Widget buildSummaryRow(String title, String value, {Color? valueColor}) =>
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: theme.textTheme.bodySmall),
            Text(value,
                style: theme.textTheme.bodySmall?.copyWith(color: valueColor)),
          ],
        );

    Widget buildOrderSummary() => Container(
          padding: EdgeInsets.all(gap * 1.5),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Summary', style: theme.textTheme.titleLarge),
              SizedBox(height: gap),
              buildSummaryRow(
                  'Subtotal', '\Rs${controller.total.toStringAsFixed(2)}'),
              SizedBox(height: gap / 2),
              buildSummaryRow('Shipping', 'FREE',
                  valueColor: theme.primaryColor),
              const Divider(height: 24),
              buildSummaryRow(
                  'Total', '\Rs${controller.total.toStringAsFixed(2)}'),
              SizedBox(height: gap * 1.5),
              CustomButton(
                text: 'Proceed to Checkout',
                onPressed: controller.onPurchaseNowPressed,
              ),
            ],
          ),
        );

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shopping Cart', style: theme.textTheme.headlineSmall),
              SizedBox(height: gap * 1.5),
              if (controller.products.isEmpty)
                const Expanded(
                  child: Center(
                    child: NoData(
                      text: 'Your Shopping Cart is Empty!',
                      isCompact: true,
                    ),
                  ),
                )
              else
                Expanded(
                  child: screenWidth > 800
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ListView.builder(
                                itemCount: controller.products.length,
                                itemBuilder: (_, index) => Padding(
                                  padding: EdgeInsets.only(bottom: gap),
                                  child: CartItem(
                                    product: controller.products[index],
                                  ).animate().fade().slideX(
                                        duration:
                                            const Duration(milliseconds: 250),
                                        begin: -0.5,
                                        curve: Curves.easeOut,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(width: gap),
                            Expanded(flex: 1, child: buildOrderSummary()),
                          ],
                        )
                      : ListView(
                          children: [
                            ...controller.products.map(
                              (product) => Padding(
                                padding: EdgeInsets.only(bottom: gap),
                                child: CartItem(product: product),
                              ),
                            ),
                            SizedBox(height: gap * 1.5),
                            Center(
                              child: SizedBox(
                                  width: screenWidth * 0.8,
                                  child: buildOrderSummary()),
                            ),
                          ],
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
