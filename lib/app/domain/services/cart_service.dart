import 'dart:async';

import 'package:ecommerce_app/app/components/custom_snackbar.dart';
import 'package:ecommerce_app/app/data/models/product_model.dart';
import 'package:ecommerce_app/app/domain/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';

class CartService extends GetxService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final AuthService _authService = Get.find<AuthService>();

  final _products = <ProductModel>[].obs;
  StreamSubscription<DatabaseEvent>? _cartSubscription;

  RxList<ProductModel> get products => _products;

  @override
  void onInit() {
    super.onInit();
    // Listen to user changes from AuthService
    ever<UserModel?>(_authService.userStream, _handleAuthChanged);
  }

  void _handleAuthChanged(UserModel? user) {
    if (user != null) {
      listenToCart(user.uid);
    } else {
      _cartSubscription?.cancel();
      _products.clear();
    }
  }

  Future<void> getCart() async {
    final userUid = _authService.user?.uid;
    if (userUid != null) {
      final snapshot = await _database.ref('carts/$userUid').get();
      if (snapshot.exists && snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        final cartProducts = data.values
            .map((productData) =>
                ProductModel.fromMap(Map<String, dynamic>.from(productData)))
            .toList();
        _products.value = cartProducts;
      } else {
        _products.clear();
      }
    }
  }

  void listenToCart(String userUid) {
    _cartSubscription?.cancel(); // Cancel any previous subscription
    _cartSubscription = _database.ref('carts/$userUid').onValue.listen((event) {
      if (event.snapshot.exists && event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        final cartProducts = data.values
            .map((productData) =>
                ProductModel.fromMap(Map<String, dynamic>.from(productData)))
            .toList();
        _products.value = cartProducts;
      } else {
        _products.clear();
      }
    });
  }

  Future<void> addToCart(ProductModel product) async {
    final userUid = _authService.user?.uid;
    if (userUid == null) return;

    final productRef = _database.ref('carts/$userUid/${product.id}');

    // Optimistic UI update
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] =
          _products[index].copyWith(quantity: _products[index].quantity + 1);
    } else {
      _products.add(product.copyWith(quantity: 1));
    }

    try {
      await productRef.runTransaction((Object? data) {
        if (data == null) {
          // If product doesn't exist, add it with quantity 1
          return Transaction.success(product.copyWith(quantity: 1).toMap());
        }
        // If product exists, increment quantity
        final Map<String, dynamic> productData =
            Map<String, dynamic>.from(data as Map);
        productData['quantity'] = (productData['quantity'] ?? 0) + 1;
        return Transaction.success(productData);
      });
    } catch (e) {
      // Revert optimistic update on error
      getCart();
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: 'Failed to add item to cart. Please try again.');
    }
  }

  Future<void> increaseQuantity(int productId) async {
    final userUid = _authService.user?.uid;
    if (userUid == null) return;

    // Optimistic UI update
    final index = _products.indexWhere((p) => p.id == productId);
    if (index == -1) return;
    _products[index] =
        _products[index].copyWith(quantity: _products[index].quantity + 1);

    try {
      final productRef = _database.ref('carts/$userUid/$productId/quantity');
      await productRef.runTransaction((Object? currentQuantity) {
        return Transaction.success((currentQuantity as int? ?? 0) + 1);
      });
    } catch (e) {
      getCart(); // Revert
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error', message: 'Failed to update quantity.');
    }
  }

  Future<void> decreaseQuantity(int productId) async {
    final userUid = _authService.user?.uid;
    if (userUid == null) return;

    final index = _products.indexWhere((p) => p.id == productId);
    if (index == -1 || _products[index].quantity <= 1) return;

    // Optimistic UI update
    _products[index] =
        _products[index].copyWith(quantity: _products[index].quantity - 1);

    try {
      final productRef = _database.ref('carts/$userUid/$productId/quantity');
      await productRef.runTransaction((Object? currentQuantity) {
        final int quantity = currentQuantity as int? ?? 1;
        if (quantity > 1) {
          return Transaction.success(quantity - 1);
        }
        return Transaction.success(1); // Ensure quantity doesn't go below 1
      });
    } catch (e) {
      getCart(); // Revert
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error', message: 'Failed to update quantity.');
    }
  }

  Future<void> removeFromCart(int productId) async {
    final userUid = _authService.user?.uid;
    if (userUid == null) return;

    // Optimistic UI update
    final removedProduct = _products.firstWhereOrNull((p) => p.id == productId);
    if (removedProduct == null) return;
    final originalList = List<ProductModel>.from(_products);
    _products.removeWhere((p) => p.id == productId);

    try {
      await _database.ref('carts/$userUid/$productId').remove();
    } catch (e) {
      _products.value = originalList; // Revert
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error', message: 'Failed to remove item.');
    }
  }

  Future<void> clearCart() async {
    final userUid = _authService.user?.uid;
    if (userUid == null) return;
    try {
      await _database.ref('carts/$userUid').remove();
    } catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error', message: 'Failed to clear cart.');
    }
  }

  void clearCartLocal() {
    _products.clear();
  }

  @override
  void onClose() {
    _cartSubscription?.cancel();
    super.onClose();
  }
}
