import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/config/theme/my_fonts.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignUpViewWeb extends GetView<SignUpController> {
  const SignUpViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    Widget buildField(
      String label,
      String hint,
      TextEditingController controller, {
      bool obscure = false,
    }) {
      return TextFormField(
        controller: controller,
        obscureText: obscure,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: theme.textTheme.bodyMedium,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          isDense: true,
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Create Account',
                        style: theme.textTheme.displayMedium),
                    const SizedBox(height: 30),
                    buildField('Full Name', 'Enter your full name',
                        controller.nameController),
                    const SizedBox(height: 15),
                    buildField('Email', 'Enter your email',
                        controller.emailController),
                    const SizedBox(height: 15),
                    buildField('Password', 'Enter your password',
                        controller.passwordController,
                        obscure: true),
                    const SizedBox(height: 25),
                    Obx(() => CustomButton(
                          text: 'Sign Up',
                          onPressed: controller.signup,
                          disabled: controller.isLoading.value,
                          verticalPadding: 10,
                          fontSize: MyFonts
                              .buttonTextSize, // This is now a raw double
                        )),
                    const SizedBox(height: 20),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? ",
                              style:
                                  theme.textTheme.bodySmall), // Smallest text
                          TextButton(
                            onPressed: () => Get.offNamed(Routes.LOGIN),
                            child: Text('Log In',
                                style: theme.textTheme.bodySmall?.copyWith(
                                    // Using theme which is safe
                                    fontSize: MyFonts.bodySmallTextSize,
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
