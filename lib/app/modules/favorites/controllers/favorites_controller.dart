import 'package:ecommerce_app/app/domain/services/favorites_service.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model.dart';

class FavoritesController extends GetxController {
  final FavoritesService _favoritesService = Get.find<FavoritesService>();

  // to hold the favorite products
  List<ProductModel> get products => _favoritesService.favoriteProducts;
}
