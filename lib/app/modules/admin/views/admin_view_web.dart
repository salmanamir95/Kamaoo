import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/admin_controller.dart';

class AdminViewWeb extends GetView<AdminController> {
  const AdminViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildOption({
      required String title,
      required IconData icon,
      VoidCallback? onTap,
    }) =>
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          child: ListTile(
            leading: Icon(icon),
            title: Text(title),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: onTap,
          ),
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600.w), // compact width
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: ListView(
              shrinkWrap: true, // prevents ListView from expanding too much
              children: [
                buildOption(
                  title: 'Upload Product',
                  icon: Icons.upload_file,
                  onTap: () => Get.toNamed(Routes.UPLOAD_PRODUCT),
                ),
                // Add more options here with buildOption(...)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
