import 'package:ecommerce_app/app/modules/cart/views/cart_view.dart';
import 'package:ecommerce_app/app/modules/favorites/views/favorites_view.dart';
import 'package:ecommerce_app/app/modules/home/views/home_view.dart';
import 'package:ecommerce_app/app/modules/settings/views/settings_view.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/app/data/models/product_model.dart';
import 'package:ecommerce_app/app/domain/services/favorites_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final FavoritesService _favoritesService = Get.find<FavoritesService>();

  // current screen index
  final RxInt currentIndex = 0.obs;

  // list of pages
  final List<Widget> pages = const [
    HomeView(),
    FavoritesView(),
    CartView(),
    SettingsView(),
  ];

  final List<String> bottomNavBarIcons = [
    Constants.homeIcon,
    Constants.favoritesIcon,
    Constants.cartIcon,
    Constants.settingsIcon,
  ];

  final List<String> bottomNavBarLabels = [
    'Home',
    'Favorites',
    'Cart',
    'Settings'
  ];

  /// change the selected screen index
  void changeScreen(int selectedIndex) => currentIndex.value = selectedIndex;

  /// when the user press on the favorite button in the product
  void onFavoriteButtonPressed({required ProductModel product}) {
    _favoritesService.toggleFavorite(product);
  }
}
