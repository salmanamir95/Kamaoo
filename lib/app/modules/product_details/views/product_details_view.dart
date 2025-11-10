import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_details_controller.dart';
import 'product_details_view_cupertino.dart';
import 'product_details_view_material.dart';
import 'product_details_view_web.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const ProductDetailsViewWeb();
    } else if (Platform.isIOS) {
      return const ProductDetailsViewCupertino();
    } else {
      return const ProductDetailsViewMaterial();
    }
  }
}
