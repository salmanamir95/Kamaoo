import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import 'cart_view_cupertino.dart';
import 'cart_view_material.dart';
import 'cart_view_web.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    // The controller is already initialized by GetX, so we can access it.
    // This widget acts as a dispatcher.
    if (kIsWeb) {
      return const CartViewWeb();
    } else if (Platform.isIOS) {
      return const CartViewCupertino();
    } else {
      // Defaults to Material for Android and other platforms.
      return const CartViewMaterial();
    }
  }
}
