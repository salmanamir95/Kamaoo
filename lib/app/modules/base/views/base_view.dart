import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/base_controller.dart';
import 'base_view_cupertino.dart';
import 'base_view_material.dart';
import 'base_view_web.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const BaseViewWeb();
    } else if (Platform.isIOS) {
      return const BaseViewCupertino();
    } else {
      return const BaseViewMaterial();
    }
  }
}
