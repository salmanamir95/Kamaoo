import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'home_view_cupertino.dart';
import 'home_view_material.dart';
import 'home_view_web.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const HomeViewWeb();
    } else if (Platform.isIOS) {
      return const HomeViewCupertino();
    } else {
      return const HomeViewMaterial();
    }
  }
}
