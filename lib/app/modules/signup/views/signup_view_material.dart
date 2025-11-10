import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:ecommerce_app/app/components/screen_title.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignUpViewMaterial extends GetView<SignUpController> {
  const SignUpViewMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.verticalSpace,
                const ScreenTitle(
                  title: 'Create Account',
                  dividerEndIndent: 150,
                ),
                30.verticalSpace,
                _buildNameField(theme),
                20.verticalSpace,
                _buildEmailField(theme),
                20.verticalSpace,
                _buildPasswordField(theme),
                30.verticalSpace,
                Obx(
                  () => CustomButton(
                    text: 'Sign Up',
                    onPressed: () => controller.signup(),
                    disabled: controller.isLoading.value,
                    verticalPadding: 12.h,
                    radius: 12.r,
                  ),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: theme.textTheme.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () => Get.offNamed(Routes.LOGIN),
                      child: Text(
                        'Log In',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField(ThemeData theme) {
    return TextFormField(
      controller: controller.nameController,
      style: theme.textTheme.bodyMedium,
      decoration: const InputDecoration(
        labelText: 'Full Name',
        hintText: 'Enter your full name',
      ),
    );
  }

  Widget _buildEmailField(ThemeData theme) {
    return TextFormField(
      controller: controller.emailController,
      style: theme.textTheme.bodyMedium,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
      ),
    );
  }

  Widget _buildPasswordField(ThemeData theme) {
    return TextFormField(
      controller: controller.passwordController,
      style: theme.textTheme.bodyMedium,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
      ),
    );
  }
}
