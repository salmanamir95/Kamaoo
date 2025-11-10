import 'package:ecommerce_app/app/domain/services/product_service.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  final ProductService _productService = Get.find<ProductService>();

  List<ProductModel> products = [];
  var isLoading = true.obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    try {
      isLoading(true);
      products = await _productService.getProducts();
    } finally {
      isLoading(false);
    }
  }
}
