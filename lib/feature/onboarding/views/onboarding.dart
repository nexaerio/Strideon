import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/feature/onboarding/controller/onboarding_controller.dart';
import 'package:strideon/feature/onboarding/widgets/onboarding_widget.dart';
import 'package:strideon/utils/constants/image_strings.dart';
import 'package:strideon/utils/constants/text_strings.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController =
        ref.watch(onBoardingControllerProvider).pageController;
    final onPageChange =
        ref.watch(onBoardingControllerProvider).updatePageIndictor;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: onPageChange,
            children: const [
              OnBoardingPage(
                  image: SImages.onBoardingImage1,
                  title: STexts.onBoardingTitle1,
                  subTitle: STexts.onBoardingSubTitle1),
              OnBoardingPage(
                  image: SImages.onBoardingImage2,
                  title: STexts.onBoardingTitle2,
                  subTitle: STexts.onBoardingSubTitle2),
              OnBoardingPage(
                  image: SImages.onBoardingImage3,
                  title: STexts.onBoardingTitle3,
                  subTitle: STexts.onBoardingSubTitle3),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigator(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
