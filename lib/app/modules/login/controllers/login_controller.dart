import 'package:ecommerce_app/app/domain/services/auth_service.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  bool get isValid =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  @override
  void onReady() {
    super.onReady();
    // Since services are initialized before the app runs, we can check the user state.
    // If the user is already logged in, redirect them to the appropriate screen.
    final user = _authService.user;
    if (user != null) {
      print(
          '[INFO] User already logged in (${user.email}). Redirecting to ${user.role == 'admin' ? 'ADMIN' : 'BASE'}...');
      Get.offNamed(user.role == 'admin' ? Routes.ADMIN : Routes.BASE);
    } else {
      print('[INFO] No user logged in. Displaying Login Screen.');
    }
  }

  void login() async {
    if (!isValid) {
      print('[WARN] Login attempt with empty email or password.');
      Get.snackbar('Error', 'Please enter both email and password');
      return;
    }

    try {
      print('[INFO] Login started for email: ${emailController.text}');

      isLoading(true);

      final user = await _authService.login(
          emailController.text, passwordController.text);

      if (user != null) {
        print(
            '[INFO] Login success for user: ${user.email}, role: ${user.role}');

        if (user.role == 'admin') {
          Get.offNamed(Routes.ADMIN);
        } else {
          Get.offNamed(Routes.BASE);
        }
      } else {
        print(
            '[WARN] Login failed: Invalid credentials for ${emailController.text}');
        Get.snackbar('Error', 'Invalid credentials');
      }
    } catch (e, st) {
      print('[ERROR] Login error: $e\n$st');
      Get.snackbar(
          'Login Error', 'An unexpected error occurred: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
