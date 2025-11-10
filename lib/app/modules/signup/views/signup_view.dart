import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import 'signup_view_cupertino.dart';
import 'signup_view_material.dart';
import 'signup_view_web.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isWeb) {
      return const SignUpViewWeb();
    } else if (GetPlatform.isIOS) {
      return const SignUpViewCupertino();
    } else {
      return const SignUpViewMaterial();
    }
  }
}
