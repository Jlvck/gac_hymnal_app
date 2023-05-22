import 'package:flutter/material.dart';

class Hymn with ChangeNotifier {
  final String id;
  final List<List<String>> verses;
  final bool isChorus;
  final List<String> chorus;
  bool isFavorites;

  Hymn({
    @required this.id,
    @required this.verses,
    @required this.isChorus,
    @required this.chorus,
    isFavorites = false,
  });
}
