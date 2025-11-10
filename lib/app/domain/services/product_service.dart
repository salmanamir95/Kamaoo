import 'package:firebase_database/firebase_database.dart';
import 'package:ecommerce_app/app/data/models/product_model.dart';
import 'package:ecommerce_app/utils/dummy_helper.dart';
import 'package:get/get.dart';

class ProductService extends GetxService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _database.ref('products').get();
    if (snapshot.exists) {
      final List<ProductModel> products = [];
      (snapshot.value as Map).forEach((key, value) {
        products.add(ProductModel.fromMap(Map<String, dynamic>.from(value)));
      });
      return products;
    } else {
      return [];
    }
  }

  Future<void> uploadDummyProducts() async {
    final products = DummyHelper.products;
    for (var product in products) {
      // In a real app, you would convert the image to a Base64 string before uploading.
      // For now, we are uploading the image path.
      await _database.ref('products/${product.id}').set(product.toMap());
    }
  }

  Future<void> uploadProduct(ProductModel product) async {
    await _database.ref('products/${product.id}').set(product.toMap());
  }
}
