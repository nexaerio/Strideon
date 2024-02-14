import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class SOutlinedButtonTheme {
  SOutlinedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: SColors.primary,
      splashFactory: InkRipple.splashFactory,
      side: const BorderSide(color: SColors.spaletteAccent, width: 1.5),
      textStyle: const TextStyle(
          fontSize: 17, color: SColors.primary, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: SSizes.buttonHeight),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: SColors.light,
      splashFactory: InkRipple.splashFactory,
      side: const BorderSide(color: SColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 17, color: SColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: SSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SSizes.buttonRadius)),
    ),
  );
}
