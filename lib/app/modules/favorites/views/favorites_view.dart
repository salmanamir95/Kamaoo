import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';
import 'favorites_view_cupertino.dart';
import 'favorites_view_material.dart';
import 'favorites_view_web.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const FavoritesViewWeb();
    } else if (Platform.isIOS) {
      return const FavoritesViewCupertino();
    } else {
      return const FavoritesViewMaterial();
    }
  }
}
