import 'package:flutter/material.dart';

import '../model/language_item.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageItem _currentItem = LanguageItem.yoruba;

  LanguageItem get currentItem => _currentItem;

  void setLanguageItem(LanguageItem selectedLanguage) {
    if (selectedLanguage == _currentItem) {
      return;
    } else {
      _currentItem = selectedLanguage;
    }
    notifyListeners();
  }
}
