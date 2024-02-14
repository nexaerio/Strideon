import 'package:flutter/material.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class SElevatedButtonTheme {
  SElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: SColors.buttonPrimary,
      foregroundColor: SColors.primaryBackground,
      disabledForegroundColor: SColors.primary,
      disabledBackgroundColor: SColors.buttonDisabled,
      splashFactory: InkRipple.splashFactory,
      padding: const EdgeInsets.symmetric(vertical: SSizes.buttonHeight),
      textStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: SColors.spalette,
      disabledForegroundColor: SColors.primary,
      disabledBackgroundColor: SColors.buttonDisabled,
      splashFactory: InkRipple.splashFactory,
      /*side: const BorderSide(color: SColors.spalette),*/
      padding: const EdgeInsets.symmetric(vertical: SSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 17, color: SColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SSizes.buttonRadius)),
    ),
  );
}
