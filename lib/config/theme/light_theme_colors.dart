import 'package:flutter/material.dart';

class LightThemeColors {
  //dark swatch
  static const Color primaryColor = Color(0xFFFF6A00); // Builder Orange
  static const Color accentColor = Color(0xFFFFD60A); // Safety Yellow

  //APPBAR
  static const Color appBarColor = primaryColor;

  //SCAFFOLD
  static const Color scaffoldBackgroundColor = Colors.white;
  static const Color backgroundColor = Colors.white; // Pure White
  static const Color dividerColor = primaryColor;
  static const Color cardColor =
      Color(0xfffafafa); // Kept for subtle differentiation

  //ICONS
  static const Color appBarIconsColor = Colors.white;
  static const Color iconColor = Color(0xFF1A1A1A); // Deep Charcoal

  //BUTTON
  static const Color buttonColor = primaryColor;
  static const Color buttonTextColor = Colors.white;
  static const Color buttonDisabledColor = Colors.grey;
  static const Color buttonDisabledTextColor =
      Color(0xFF1A1A1A); // Deep Charcoal

  //TEXT
  static const Color bodyTextColor = Color(0xFF1A1A1A); // Deep Charcoal
  static const Color displayTextColor = Color(0xFF1A1A1A); // Deep Charcoal
  static const Color bodySmallTextColor = Color(0xFF1A1A1A); // Deep Charcoal
  static const Color hintTextColor = Color(0xff686868); // Kept for hints

  //chip
  static const Color chipBackground = primaryColor;
  static const Color chipTextColor = Colors.white;

  // progress bar indicator
  static const Color progressIndicatorColor =
      Color(0xFFFF6A00); // Builder Orange
}
