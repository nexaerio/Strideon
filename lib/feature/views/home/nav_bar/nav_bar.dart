import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/feature/views/home/main_page.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/device/device_utility.dart';

Consumer navBar() {
  return Consumer(
    builder: (context, ref, child) {
      final currentIndex = ref.watch(bottomNavIndexProvider);
      return NavigationBar(
        height: SDeviceUtils.getBottomNavigationBarHeight() * 1.1,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? SColors.darkBackground
            : SColors.primaryBackground,
        // indicatorColor: SColors.accent,
        elevation: 0,
        animationDuration: const Duration(milliseconds: 1),
        /*indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),*/
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.chat_rounded), label: 'Stride'),
          NavigationDestination(
              icon: Icon(Icons.view_kanban_rounded), label: 'Board'),
        ],
        onDestinationSelected: (value) {
          ref.read(bottomNavIndexProvider.notifier).update((state) => value);
        },
      );
    },
  );
}
