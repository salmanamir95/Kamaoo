import 'package:ecommerce_app/app/domain/services/cart_service.dart';
import 'package:get/get.dart';

import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class CartController extends GetxController {
  final CartService _cartService = Get.find<CartService>();

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // to hold the products in cart
  RxList<ProductModel> get products => _cartService.products;

  // to hold the total price of the cart products
  double get total =>
      products.fold(0, (sum, item) => sum + (item.price * item.quantity));

  /// when the user press on purchase now button
  Future<void> onPurchaseNowPressed() async {
    _isLoading.value = true;
    Get.find<BaseController>().changeScreen(0);
    CustomSnackBar.showCustomSnackBar(
        title: 'Purchased', message: 'Order placed with success');
    await _cartService.clearCart();
    _isLoading.value = false;
  }

  /// when the user press on increase button
  Future<void> onIncreasePressed(int productId) async {
    _isLoading.value = true;
    await _cartService.increaseQuantity(productId);
    _isLoading.value = false;
  }

  /// when the user press on decrease button
  Future<void> onDecreasePressed(int productId) async {
    final product = products.firstWhereOrNull((p) => p.id == productId);
    if (product != null && product.quantity <= 1) return;

    _isLoading.value = true;
    await _cartService.decreaseQuantity(productId);
    _isLoading.value = false;
  }

  /// when the user press on delete icon
  Future<void> onDeletePressed(int productId) async {
    _isLoading.value = true;
    await _cartService.removeFromCart(productId);
    _isLoading.value = false;
  }
}
