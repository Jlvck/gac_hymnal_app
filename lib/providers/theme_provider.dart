import 'package:flutter/material.dart';

import '../theme_class.dart';

class ThemeProvider extends ChangeNotifier {
  //Light ThemeData
  ThemeData light = ThemeClass.lightTheme;
  //Dark ThemeData
  ThemeData dark = ThemeClass.darkTheme;

  //Value serves as a flag
  ThemeMode currentTheme = ThemeMode.light;

  //currrent brightness..which is given a value when the app is initialized
  Brightness? currentBrigtness;

  ThemeMode get themeMode => currentTheme;

  //Function to set theme
  void setTheme(Brightness brightness) {
    //conditional statements so as to avoid unnecessary rebuild
    //could happen when a user keeps pressing the light mode button
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
