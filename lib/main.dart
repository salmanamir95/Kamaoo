import 'package:ecommerce_app/app/domain/services/cart_service.dart';
import 'package:ecommerce_app/app/domain/services/favorites_service.dart';
import 'package:ecommerce_app/app/domain/services/auth_service.dart';
import 'dart:async';
import 'package:ecommerce_app/app/domain/services/product_service.dart';
import 'package:ecommerce_app/app/domain/services/order_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/data/local/my_shared_pref.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // init shared preference
  await MySharedPref.init();

  // Initialize services in the background
  await initServices();

  runApp(
    // We need to initialize services before running the app
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      // The builder here should return your root app widget.
      builder: (context, child) {
        return GetMaterialApp(
          title: "Kamaoo",
          debugShowCheckedModeBanner: false,
          theme: MyTheme.getThemeData(isLight: true),
          darkTheme: MyTheme.getThemeData(isLight: false),
          themeMode:
              MySharedPref.getThemeIsLight() ? ThemeMode.light : ThemeMode.dark,
          initialRoute: AppPages.INITIAL, // first screen to show
          getPages: AppPages.routes, // app screens
        );
      },
    ),
  );
}

Future<void> initServices() async {
  // This will initialize Firebase in the background
  // and all essential services before the app runs.
  await Get.putAsync(() => InitializationService().init(), permanent: true);
}

class InitializationService extends GetxService {
  Future<InitializationService> init() async {
    try {
      print('[INFO] InitializationService: init() started');

      // 1. Create and initialize AuthService instance directly.
      final authService = await AuthService().init();
      // 2. Register the already-initialized instance with GetX.
      Get.put(authService, permanent: true);
      print('[INFO] AuthService initialized');

      // 3. Eagerly initialize Cart and Favorites services to listen for auth changes.
      Get.put(CartService(), permanent: true);
      Get.put(FavoritesService(), permanent: true);

      // 4. Lazy load other services.
      Get.lazyPut(() => ProductService());
      Get.lazyPut(() => OrderService());

      print('[INFO] InitializationService completed successfully');
    } catch (e, st) {
      print('[ERROR] Service initialization failed: $e\n$st');
    }
    return this;
  }
}
