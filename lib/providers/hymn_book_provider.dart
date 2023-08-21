import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../hymn_texts/hymn_text_1_100.dart';

import '../model/hymn.dart';

class HymnBookProvider with ChangeNotifier {
  static const String prefKey = "favList";

  List<String> favStringList = [];

  //simple manipulation i did to ensure when
  //the fav button is clicked in favorite screen the effect is rapid

  //adding an id to favorite list of id
  void addPrefFav(String id) {
    favStringList.add(id);
  }

  //removing an id to favorite list of id
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
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 0, 0)),
        ),
        backgroundColor: Colors.white,
        showCloseIcon: true,
        closeIconColor: Theme.of(ctx).secondaryHeaderColor,
        duration: const Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          'Hymn $id favorited',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(ctx).secondaryHeaderColor,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: const Duration(seconds: 1),
      ));
      addPrefFav(id);
    }
    addListtoSharedPref(favStringList);
  }

  //overwrite the saved shared preferences intance with another
  void addListtoSharedPref(List<String> fav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefKey, favStringList);
  }

  // Screen Function for the Slash screen which works by setting saved
  //shared preferences intance of a list of saved favorite hymn ids
  void setFavHymnList() async {
    List<Hymn> pre = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favStringList = prefs.getStringList(prefKey) ?? [];
    List<String> fav = prefs.getStringList(prefKey) ?? [];

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
    ...HymnText1to100().hymntext,
  ];
}
