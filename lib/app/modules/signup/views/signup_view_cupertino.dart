import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignUpViewCupertino extends GetView<SignUpController> {
  const SignUpViewCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          children: [
            SizedBox(height: 40.h),
            Image.asset(
              'assets/images/Kamao-Logo-updated.png',
              height: 120.h,
            ),
            SizedBox(height: 40.h),
            CupertinoTextField(
              controller: controller.nameController,
              placeholder: 'Full Name',
              prefix: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Icon(CupertinoIcons.person,
                    color: CupertinoColors.systemGrey),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 16.h),
            CupertinoTextField(
              controller: controller.emailController,
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              prefix: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Icon(CupertinoIcons.mail,
                    color: CupertinoColors.systemGrey),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 16.h),
            CupertinoTextField(
              controller: controller.passwordController,
              placeholder: 'Password',
              obscureText: true,
              prefix: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Icon(CupertinoIcons.lock,
                    color: CupertinoColors.systemGrey),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 24.h),
            Obx(
              () => CupertinoButton.filled(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.signup(),
                child: controller.isLoading.value
                    ? const CupertinoActivityIndicator()
                    : const Text('Sign Up'),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                      color: CupertinoColors.secondaryLabel, fontSize: 12.sp),
                ),
                CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  onPressed: () => Get.offNamed(Routes.LOGIN),
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
