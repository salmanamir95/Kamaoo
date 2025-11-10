import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/admin_controller.dart';

class AdminViewMaterial extends GetView<AdminController> {
  const AdminViewMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Upload Product'),
              leading: const Icon(Icons.upload_file),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Get.toNamed(Routes.UPLOAD_PRODUCT),
            ),
          ],
        ),
      ),
    );
  }
}
