import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_app/app/modules/admin/controllers/upload_product_controller.dart';

class UploadProductView extends GetView<UploadProductController> {
  const UploadProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                if (controller.imagePath == null) {
                  return GestureDetector(
                    onTap: controller.pickImage,
                    child: Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: const Icon(Icons.add_a_photo, size: 50),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: controller.pickImage,
                    child: SizedBox(
                      width: 120.w,
                      height: 120.w,
                      child: kIsWeb
                          ? Image.network(controller.imagePath!)
                          : Image.file(File(controller.imagePath!)),
                    ),
                  );
                }
              }),
              SizedBox(height: 20.h),
              _buildTextField(controller.nameController, 'Product Name'),
              _buildTextField(controller.priceController, 'Price',
                  keyboardType: TextInputType.number),
              _buildTextField(controller.ratingController, 'Rating',
                  keyboardType: TextInputType.number),
              _buildTextField(controller.reviewsController, 'Reviews Count',
                  keyboardType: TextInputType.number),
              _buildTextField(
                  controller.sizeController, 'Size (e.g., S, M, L)'),
              SizedBox(height: 30.h),
              Obx(() {
                return ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.uploadProduct,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Upload Product'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
