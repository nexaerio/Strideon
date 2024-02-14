import 'package:flutter/material.dart';
import 'package:strideon/utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final String text;

  const CustomButton(
      {super.key, required this.voidCallback, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: SColors.buttonPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 19)),
        onPressed: voidCallback,
        child: Text(
          text,
          style: const TextStyle(color: SColors.light),
        ));
  }
}
