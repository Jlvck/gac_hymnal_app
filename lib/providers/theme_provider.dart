import 'package:flutter/material.dart';

import '../theme_class.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData light = ThemeClass.lightTheme;
  ThemeData dark = ThemeClass.darkTheme;
  ThemeMode currentTheme = ThemeMode.light;
  Brightness? currentBrigtness;

  ThemeMode get themeMode => currentTheme;
  void setTheme(Brightness brightness) {
    if (brightness == Brightness.light && brightness != currentBrigtness) {
      currentTheme = ThemeMode.light;
      currentBrigtness = Brightness.light;
      notifyListeners();
    } else {
      if (brightness == Brightness.dark && brightness != currentBrigtness) {
        currentTheme = ThemeMode.dark;
        currentBrigtness = Brightness.dark;
        notifyListeners();
      }
    }
  }
}
