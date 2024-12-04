import 'package:flutter/material.dart';

class Hymn with ChangeNotifier {
  final String id;
  final List<List<String>> versesYoruba;
  final List<String>? chorusYoruba;
  final List<List<String>> versesEnglish;
  final List<String>? chorusEnglish;
  bool isFavorites = false;
  final String hymnTitleEnglish;
  final String hymnTitleYoruba;

  void toggleFav() {
    isFavorites = !isFavorites;
    notifyListeners();
  }

  Hymn(
      {required this.id,
      required this.versesYoruba,
      this.chorusYoruba,
      required this.versesEnglish,
      this.chorusEnglish})
      : hymnTitleEnglish = versesEnglish[0][0],
        hymnTitleYoruba = versesYoruba[0][0];
}
