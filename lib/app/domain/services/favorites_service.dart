import 'dart:async';

import 'package:ecommerce_app/app/data/models/product_model.dart';
import 'package:ecommerce_app/app/domain/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';

class FavoritesService extends GetxService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final AuthService _authService = Get.find<AuthService>();

  final _favoriteProducts = <ProductModel>[].obs;
  StreamSubscription<DatabaseEvent>? _favoritesSubscription;

  List<ProductModel> get favoriteProducts => _favoriteProducts;

  @override
  void onInit() {
    super.onInit();
    ever<UserModel?>(_authService.userStream, _handleAuthChanged);
  }

  void _handleAuthChanged(UserModel? user) {
    if (user != null) {
      listenToFavorites(user.uid);
    } else {
      _favoritesSubscription?.cancel();
      _favoriteProducts.clear();
    }
  }

  Future<void> getFavorites() async {
    final userUid = _authService.user?.uid;
    if (userUid != null) {
      final snapshot = await _database.ref('favorites/$userUid').get();
      if (snapshot.exists && snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        final favoriteProducts = data.values
            .map((productData) =>
                ProductModel.fromMap(Map<String, dynamic>.from(productData)))
            .toList();
        _favoriteProducts.value = favoriteProducts;
      } else {
        _favoriteProducts.clear();
      }
    }
  }

  void listenToFavorites(String userUid) {
    _favoritesSubscription?.cancel();
    _favoritesSubscription =
        _database.ref('favorites/$userUid').onValue.listen((event) {
      if (event.snapshot.exists && event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        final favorites = data.values
            .map((productData) =>
                ProductModel.fromMap(Map<String, dynamic>.from(productData)))
            .toList();
        _favoriteProducts.value = favorites;
      } else {
        _favoriteProducts.clear();
      }
    });
  }

  void toggleFavorite(ProductModel product) async {
    final userUid = _authService.user?.uid;
    if (userUid != null) {
      final isCurrentlyFavorite = isFavorite(product.id);
      if (!isCurrentlyFavorite) {
        await _database
            .ref('favorites/$userUid/${product.id}')
            .set(product.copyWith(isFavorite: true).toMap());
      } else {
        await _database.ref('favorites/$userUid/${product.id}').remove();
      }
    }
  }

  bool isFavorite(int productId) {
    return _favoriteProducts.any((p) => p.id == productId);
  }

  void clearFavoritesLocal() {
    _favoriteProducts.clear();
  }

  @override
  void onClose() {
    _favoritesSubscription?.cancel();
    super.onClose();
  }
}
