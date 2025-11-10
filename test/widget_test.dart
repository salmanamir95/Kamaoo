import 'package:ecommerce_app/app/data/local/my_shared_pref.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:ecommerce_app/config/theme/my_theme.dart';
import 'package:ecommerce_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('App starts and displays splash screen', (WidgetTester tester) async {
    // Initialize services
    await MySharedPref.init();
    await initServices();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (old, data) => true,
        builder: (context, widget) {
          return GetMaterialApp(
            title: "Kamaoo",
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              bool themeIsLight = MySharedPref.getThemeIsLight();
              return Theme(
                data: MyTheme.getThemeData(isLight: themeIsLight),
                child: MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.linear(1.0)),
                  child: widget!,
                ),
              );
            },
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        },
      ),
    );

    // Wait for all animations to complete.
    await tester.pumpAndSettle();

    // Verify that the splash screen content is visible.
    expect(find.text('WELCOME!'), findsOneWidget);
  });
}