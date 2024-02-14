import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strideon/utils/constants/colors.dart';

class BoardActionButton extends StatelessWidget {
  const BoardActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      shape: const CircleBorder(),
      backgroundColor: SColors.spaletteAccent,
      foregroundColor: SColors.white,
      splashColor: SColors.primaryBackground,
      child: const Icon(
        CupertinoIcons.zoom_in,
        size: 30,
        color: SColors.black,
      ),
    );
  }
}
