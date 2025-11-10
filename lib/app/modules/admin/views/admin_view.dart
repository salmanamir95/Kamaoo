import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/admin_controller.dart';
import 'admin_view_cupertino.dart';
import 'admin_view_material.dart';
import 'admin_view_web.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const AdminViewWeb();
    } else if (Platform.isIOS) {
      return const AdminViewCupertino();
    } else {
      return const AdminViewMaterial();
    }
  }
}
