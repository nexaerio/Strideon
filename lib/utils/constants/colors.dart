import 'package:flutter/material.dart';

class SColors {
  static const MaterialColor spalette =
      MaterialColor(_spalettePrimaryValue, <int, Color>{
    50: Color(0xFFE8E2FC),
    100: Color(0xFFC6B6F6),
    200: Color(0xFFA186F1),
    300: Color(0xFF7B56EB),
    400: Color(0xFF5E31E6),
    500: Color(_spalettePrimaryValue),
    600: Color(0xFF3C0BDF),
    700: Color(0xFF3309DA),
    800: Color(0xFF2B07D6),
    900: Color(0xFF1D03CF),
  });
  static const int _spalettePrimaryValue = 0xFF420DE2;

  static const MaterialColor spaletteAccent =
      MaterialColor(_spaletteAccentValue, <int, Color>{
    100: Color(0xFFF7F6FF),
    200: Color(_spaletteAccentValue),
    400: Color(0xFF9A90FF),
    700: Color(0xFF8377FF),
  });
  static const int _spaletteAccentValue = 0xFFC9C3FF;

  //Custom Color

  static const greyColor = Color.fromRGBO(26, 39, 45, 1);

  // App theme colors
  static const Color primary = Color(0xFF5E17EB);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFD9D3FF);

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  // Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color darkBackground = Color(0xFF121212);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = SColors.white.withOpacity(0.1);
  static Color darkBottomSheet = SColors.darkBackground.withOpacity(0.9);

  // Button colors
  static const Color buttonPrimary = Color(0xFF420DE2);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
}
