import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/admin_controller.dart';

class AdminViewCupertino extends GetView<AdminController> {
  const AdminViewCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Admin Panel'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile.notched(
                  title: const Text('Upload Product'),
                  leading: const Icon(CupertinoIcons.cloud_upload),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => Get.toNamed(Routes.UPLOAD_PRODUCT),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
