import 'package:ecommerce_app/app/components/custom_snackbar.dart';
import 'package:ecommerce_app/app/domain/services/cart_service.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class ProductDetailsController extends GetxController {
  // get product details from arguments
  ProductModel product = Get.arguments;

  // for the product size
  var selectedSize = 'M';

  /// when the user press on the favorite button
  void onFavoriteButtonPressed() {
    Get.find<BaseController>().onFavoriteButtonPressed(product: product);
  }

  /// when the user press on add to cart button
  void onAddToCartPressed() {
    product.size = selectedSize;
    Get.find<CartService>().addToCart(product);
    CustomSnackBar.showCustomSnackBar(
        title: 'Success', message: 'Product added to cart');
    Get.back();
  }

  /// change the selected size
  void changeSelectedSize(String size) {
    if (size == selectedSize) return;
    selectedSize = size;
    update(['Size']);
  }
}
