import 'package:flutter/material.dart';

import '../../../../model/navigation_item.dart';

//Navigation Class Provider used by the drawer widget
class NavigationProvider extends ChangeNotifier {
  NavigationItem _navigationItem = NavigationItem.hymnbook;

  NavigationItem get navigationItem => _navigationItem;

  void setNavigationItem(NavigationItem navigationItem) {
    _navigationItem = navigationItem;

    notifyListeners();
  }
}
