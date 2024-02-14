import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/feature/auth/views/welcome_screen.dart';

final onBoardingControllerProvider = Provider((ref) => OnBoardingController());

class OnBoardingController {
  final pageController = PageController();
  int currentPageIndex = 0;

  void updatePageIndictor(index) => currentPageIndex = index;

  void dotNavigatorClick(index) {
    currentPageIndex = index;
    pageController.jumpTo(index);
  }

  void nextPage(BuildContext context) {
    if (currentPageIndex == 2) {
      _onIntroEnd(context);
    } else {
      int page = currentPageIndex + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex = 2;
    pageController.jumpToPage(2);
  }

  void _onIntroEnd(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ));
  }
}
