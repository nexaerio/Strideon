import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:strideon/feature/onboarding/controller/onboarding_controller.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';
import 'package:strideon/utils/device/device_utility.dart';
import 'package:strideon/utils/helpers/helper_functions.dart';

class OnBoardingDotNavigator extends ConsumerWidget {
  const OnBoardingDotNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onBoardingControllerProvider);
    final pageController =
        ref.watch(onBoardingControllerProvider).pageController;

    final dark = SHelperFunctions.isDarkMode(context);

    return Positioned(
        bottom: SDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: SSizes.defaultSpace,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigatorClick,
          count: 3,
          effect: ExpandingDotsEffect(
              activeDotColor: dark ? SColors.primary : SColors.dark,
              dotHeight: 6),
        ));
  }
}
