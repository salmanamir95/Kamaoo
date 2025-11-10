import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginViewMaterial extends GetView<LoginController> {
  const LoginViewMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80.h),
              Image.asset(
                'assets/images/Kamao-Logo-updated.png',
                height: 150.h,
              ),
              SizedBox(height: 48.h),
              _buildEmailField(),
              SizedBox(height: 16.h),
              _buildPasswordField(),
              SizedBox(height: 24.h),
              _buildLoginButton(),
              SizedBox(height: 16.h),
              _buildForgotPassword(),
              SizedBox(height: 48.h),
              _buildSignUp(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: TextField(
          controller: controller.emailController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.email_outlined),
            labelText: 'Email',
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: TextField(
          controller: controller.passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.lock_outline),
            labelText: 'Password',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Obx(() {
      return ElevatedButton(
        onPressed: controller.isLoading.value ? null : controller.login,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Login'),
      );
    });
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {
        // TODO: Implement forgot password functionality
      },
      child: Text(
        'Forgot Password?',
        style: Get.theme.textTheme.bodySmall
            ?.copyWith(color: Get.theme.primaryColor),
      ),
    );
  }

  Widget _buildSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?", style: Get.theme.textTheme.bodySmall),
        TextButton(
          onPressed: () => Get.toNamed(Routes.SIGNUP),
          child: Text(
            'Sign Up',
            style: Get.theme.textTheme.bodySmall?.copyWith(
              color: Get.theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
