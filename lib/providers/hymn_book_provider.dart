import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../hymn_texts/hymn_text_1_50.dart';
import '../hymn_texts/hymn_text_51_100.dart';
import '../hymn_texts/hymn_text_101_150.dart';
import '../hymn_texts/hymn_text_151_200.dart';
import '../hymn_texts/hymn_text_201_250.dart';
import '../hymn_texts/hymn_text_251_300.dart';
import '../hymn_texts/hymn_text_301_350.dart';
import '../hymn_texts/hymn_text_351_400.dart';
import '../hymn_texts/hymn_text_401_450.dart';
import '../hymn_texts/hymn_text_451_500.dart';

import '../model/hymn.dart';

class HymnBookProvider with ChangeNotifier {
  //sharedpref key for favList
  static const String prefFavKey = "favList";

  List<String> favStringList = [];

  //adding an id to favorite list of id
  void addPrefFav(String id) {
    favStringList.add(id);
  }

  //removing an id from favorite list of id
  void removePrefFav(String id) {
    favStringList.remove(id);
  }

  //called upon when the favorite button is clicked
  //it runs the mechanism for adding or removing an id from favorites list
  void checkfav(String id, BuildContext ctx) {
    if (favStringList.contains(id)) {
      removePrefFav(id);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          'Hymn $id unfavorited',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(ctx).secondaryHeaderColor),
        ),
        backgroundColor: Colors.white,
        showCloseIcon: true,
        closeIconColor: Theme.of(ctx).secondaryHeaderColor,
        duration: const Duration(seconds: 1),
      ));
    } else {
      addPrefFav(id);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          'Hymn $id favorited',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Theme.of(ctx).secondaryHeaderColor,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: const Duration(seconds: 1),
      ));
    }
    addListtoSharedPref(favStringList);
  }

  //overwrite the saved shared preferences intance with another
  void addListtoSharedPref(List<String> fav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefFavKey, favStringList);
  }

  // Screen Function for the Slash screen which works by setting saved
  //shared preferences intance of a list of saved favorite hymn ids
  void setFavHymnList() async {
    List<Hymn> pre = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favStringList = prefs.getStringList(prefFavKey) ?? [];
    List<String> fav = favStringList;

    //validating function of list of hymns that are saved as favorites
    for (Hymn hymn in _hymnBook) {
      if (fav.contains(hymn.id)) {
        hymn.isFavorites = true;
        pre.add(hymn);
      } else {
        pre.add(hymn);
      }
    }

    _hymnBook = pre;
    notifyListeners();
  }

  Future<bool> checkFavHymnListStrings(String id) async {
    List<String> fav = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    fav = prefs.getStringList(prefFavKey) ?? [];

    if (fav.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

  //search operations function required to fetch hymn from
  //the original hymn
  Hymn getHymn(String hymnNumber) {
    return _hymnBook.firstWhere((hymn) => hymn.id == hymnNumber);
  }

  //Returning List of Favavorite Hymn List to Favorite Screen
  List<Hymn> get favHymnList {
    List<Hymn> favList =
        _hymnBook.where((hymn) => hymn.isFavorites == true).toList();

    return favList;
  }

  //Returning a copy of original List
  List<Hymn> get hymnList {
    return [..._hymnBook];
  }

  //The Original List of Hymn
  List<Hymn> _hymnBook = [
    ...HymnText1to50().hymnLyrics,
    ...HymnText51to100().hymnLyrics,
    ...HymnText101to150().hymnLyrics,
    ...HymnText151to200().hymnLyrics,
    ...HymnText201to250().hymnLyrics,
    ...HymnText251to300().hymnLyrics,
    ...HymnText301to350().hymnLyrics,
    ...HymnText351to400().hymnLyrics,
    ...HymnText401to450().hymnLyrics,
    ...HymnText451to500().hymnLyrics,
  ];
}
