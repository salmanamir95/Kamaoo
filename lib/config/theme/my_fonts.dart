import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// todo configure text family and size
class MyFonts {
  // return the right font depending on app language
  static TextStyle get getAppFontType => const TextStyle(fontFamily: 'Poppins');

  // headlines text font
  static TextStyle get headlineTextStyle => getAppFontType;

  // body text font
  static TextStyle get bodyTextStyle => getAppFontType;

  // button text font
  static TextStyle get buttonTextStyle => getAppFontType;

  // app bar text font
  static TextStyle get appBarTextStyle => getAppFontType;

  // chips text font
  static TextStyle get chipTextStyle => getAppFontType;

  // appbar font size
  static double get appBarTittleSize => kIsWeb ? 16.0 : 14.0;

  // headlines text font
  static TextStyle get displayTextStyle => getAppFontType;

  // body font size
  static double get bodySmallTextSize => kIsWeb ? 12.0 : 11.0;

  static double get bodyMediumSize => kIsWeb ? 14.0 : 12.0; // default font

  static double get bodyLargeSize => kIsWeb ? 16.0 : 14.0;

  // display font size
  static double get displayLargeSize => kIsWeb ? 34.0 : 28.0;

  static double get displayMediumSize => kIsWeb ? 28.0 : 22.0;

  static double get displaySmallSize => kIsWeb ? 18.0 : 16.0;

  // body font size
  static double get body1TextSize => bodyLargeSize;
  static double get body2TextSize => bodyMediumSize;

  //button font size
  static double get buttonTextSize => kIsWeb ? 15.0 : 14.0;

  //caption font size
  static double get captionTextSize => bodySmallTextSize;

  //chip font size
  static double get chipTextSize => bodyMediumSize;
}
