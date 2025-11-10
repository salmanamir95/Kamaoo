import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce_app/app/data/models/product_model.dart';
import 'package:ecommerce_app/app/domain/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadProductController extends GetxController {
  final ProductService _productService = Get.find<ProductService>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final ratingController = TextEditingController();
  final reviewsController = TextEditingController();
  final sizeController = TextEditingController();

  final _imagePath = Rx<String?>(null);
  String? get imagePath => _imagePath.value;

  Uint8List? _imageBytes;

  final isLoading = false.obs;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imagePath.value = pickedFile.path;
      _imageBytes = await pickedFile.readAsBytes();
    }
  }

  Future<void> uploadProduct() async {
    if (_imageBytes == null) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }

    try {
      isLoading(true);
      final imageBase64 = base64Encode(_imageBytes!);

      final newProduct = ProductModel(
        id: DateTime.now().millisecondsSinceEpoch, // Generate a unique ID
        name: nameController.text,
        price: double.parse(priceController.text),
        rating: double.parse(ratingController.text),
        reviews: int.parse(reviewsController.text),
        size: sizeController.text,
        image: imageBase64,
      );

      await _productService.uploadProduct(newProduct);
      Get.back();
      Get.snackbar('Success', 'Product uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
