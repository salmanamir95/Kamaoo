import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import 'login_view_cupertino.dart';
import 'login_view_material.dart';
import 'login_view_web.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const LoginViewWeb();
    } else if (Platform.isIOS) {
      return const LoginViewCupertino();
    } else {
      return const LoginViewMaterial();
    }
  }
}
