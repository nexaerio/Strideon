import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:strideon/feature/onboarding/controller/onboarding_controller.dart';

import 'package:strideon/utils/constants/sizes.dart';
import 'package:strideon/utils/constants/text_strings.dart';
import 'package:strideon/utils/device/device_utility.dart';

class OnBoardingSkip extends ConsumerWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void skipPage() {
      ref.watch(onBoardingControllerProvider).skipPage();
    }

    return Positioned(
        top: SDeviceUtils.getAppBarHeight(),
        right: SSizes.defaultSpace,
        child: TextButton(
          onPressed: skipPage,
          child: const Text(STexts.skip),
        ));
  }
}
