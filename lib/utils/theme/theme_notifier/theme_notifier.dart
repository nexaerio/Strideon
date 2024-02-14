import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appThemeStateNotifier = ChangeNotifierProvider((ref) => SAppThemeState());

class SAppThemeState extends ChangeNotifier {
  var isDarkModeEnabled = false;

  SAppThemeState() {
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;
    notifyListeners();
  }

  void setLightTheme() {
    isDarkModeEnabled = false;
    _saveTheme();
    notifyListeners();
  }

  void setDarkTheme() {
    isDarkModeEnabled = true;
    _saveTheme();
    notifyListeners();
  }

  void _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkModeEnabled', isDarkModeEnabled);
  }
}
