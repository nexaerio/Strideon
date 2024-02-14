import 'package:flutter/material.dart';
import 'package:strideon/utils/theme/widget_themes/appbar_theme.dart';
import 'package:strideon/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:strideon/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:strideon/utils/theme/widget_themes/chip_theme.dart';
import 'package:strideon/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:strideon/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:strideon/utils/theme/widget_themes/text_field_theme.dart';
import 'package:strideon/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class SAppTheme {
  SAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    disabledColor: SColors.grey,
    primarySwatch: SColors.spalette,
    textTheme: STextTheme.lightTextTheme,
    chipTheme: SChipTheme.lightChipTheme,
    scaffoldBackgroundColor: SColors.primaryBackground,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    checkboxTheme: SCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,

    // hoverColor: Colors.transparent,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: SColors.grey,
    brightness: Brightness.dark,
    primarySwatch: SColors.spalette,
    textTheme: STextTheme.darkTextTheme,
    chipTheme: SChipTheme.darkChipTheme,
    scaffoldBackgroundColor: SColors.darkBackground,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    checkboxTheme: SCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,
  );
}
