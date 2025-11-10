import 'package:ecommerce_app/app/domain/services/auth_service.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;

  void signup() async {
    try {
      isLoading(true);
      await _authService.signup(
        nameController.text,
        emailController.text,
        passwordController.text,
        'user',
      );
      Get.offNamed(Routes.BASE);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
