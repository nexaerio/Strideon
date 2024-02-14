import 'package:flutter/material.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: SColors.primaryBackground,
            backgroundColor: SColors.buttonPrimary,
            splashFactory: InkRipple.splashFactory,
            minimumSize: const Size(
              double.infinity,
              SSizes.buttonHeight,
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: SColors.light,
          ),
        ));
  }
}
