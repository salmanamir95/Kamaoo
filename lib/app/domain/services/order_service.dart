import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/app/data/models/product_model.dart';

class OrderService extends GetxService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> placeOrder({
    required String userId,
    required double totalAmount,
    required List<ProductModel> products,
  }) async {
    final orderId = _database.ref().child('orders').push().key;
    if (orderId != null) {
      final productsMap = <String, dynamic>{};
      for (var product in products) {
        productsMap[product.id.toString()] = {
          'quantity': product.quantity,
          'price': product.price,
        };
      }

      await _database.ref('orders/$orderId').set({
        'userId': userId,
        'orderDate': DateTime.now().toIso8601String(),
        'totalAmount': totalAmount,
        'products': productsMap,
      });
    }
  }

  Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    final snapshot = await _database.ref('orders').orderByChild('userId').equalTo(userId).get();
    final List<Map<String, dynamic>> orders = [];
    if (snapshot.exists) {
      (snapshot.value as Map).forEach((key, value) {
        orders.add(Map<String, dynamic>.from(value));
      });
    }
    return orders;
  }

  Future<Map<String, dynamic>?> getOrderById(String orderId) async {
    final snapshot = await _database.ref('orders/$orderId').get();
    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    }
    return null;
  }
}
