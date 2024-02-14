import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/feature/onboarding/controller/onboarding_controller.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';
import 'package:strideon/utils/device/device_utility.dart';
import 'package:strideon/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends ConsumerWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void nextButton() {
      ref.watch(onBoardingControllerProvider).nextPage(context);
    }

    final dark = SHelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: SDeviceUtils.getBottomNavigationBarHeight(),
        right: SSizes.defaultSpace,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? SColors.buttonPrimary : Colors.black,
          ),
          onPressed: nextButton,
          child: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.white,
          ),
        ));
  }
}
