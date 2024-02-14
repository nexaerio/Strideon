import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
      {super.key, required this.voidCallback, required this.text});

  final VoidCallback voidCallback;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 19)),
        onPressed: voidCallback,
        child: Text(text));
  }
}
