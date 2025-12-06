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

  // load environment variables from .env file
  //await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // init shared preference
  await MySharedPref.init();

  // Initialize services in the background
  await initServices();

  runApp(
    GetMaterialApp(
      title: "Kamaoo",
      debugShowCheckedModeBanner: false,
      theme: MyTheme.getThemeData(isLight: true),
      darkTheme: MyTheme.getThemeData(isLight: false),
      themeMode:
          MySharedPref.getThemeIsLight() ? ThemeMode.light : ThemeMode.dark,
      initialRoute: AppPages.INITIAL, // first screen to show
      getPages: AppPages.routes, // app screens
      // Use the builder to wrap your pages with ScreenUtilInit
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: child,
        );
      },
    ), // GetMaterialApp
  );
}

Future<void> initServices() async {
  print('[INFO] Initializing services...');
  try {
    // 1. Initialize and register AuthService. It's crucial to have it ready first.
    await Get.putAsync(() => AuthService().init(), permanent: true);
    print('[INFO] AuthService initialized.');

    // 2. Eagerly initialize services that need to listen to auth state changes immediately.
    Get.put(CartService(), permanent: true);
    Get.put(FavoritesService(), permanent: true);
    print('[INFO] CartService and FavoritesService registered.');

    // 3. Lazily initialize other services that are not needed immediately at startup.
    Get.lazyPut(() => ProductService(), fenix: true);
    Get.lazyPut(() => OrderService(), fenix: true);
    print('[INFO] ProductService and OrderService registered lazily.');

    print('[INFO] All services initialized successfully.');
  } catch (e, st) {
    print('[ERROR] Service initialization failed: $e\n$st');
  }
}
