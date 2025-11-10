import 'package:ecommerce_app/app/domain/services/auth_service.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_pref.dart';

class SettingsController extends GetxController {
  final AuthService authService = Get.find<AuthService>();

  // Use RxBool for reactive state management
  late final RxBool isDarkMode;

  @override
  void onInit() {
    super.onInit();
    // Initialize isDarkMode based on the stored theme preference
    isDarkMode = MySharedPref.getThemeIsLight().obs;
  }

  /// Toggles the theme between light and dark mode.
  void onChangeThemePressed() {
    MyTheme.changeTheme();
    isDarkMode.value = MySharedPref.getThemeIsLight();
  }

  void onLogoutPressed() async {
    await authService.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
