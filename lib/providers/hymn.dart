import 'package:flutter/material.dart';

class Hymn with ChangeNotifier {
  final String id;
  final List<List<String>> verses;
  final bool isChorus;
  final List<String> chorus;
  bool isFavorites = false;

  void toggleFav() {
    isFavorites = !isFavorites;
    notifyListeners();
  }

  Hymn({
    @required this.id,
    @required this.verses,
    @required this.isChorus,
    @required this.chorus,
  });
}
