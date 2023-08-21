// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hymn_book_provider.dart';
import '../widgets/drawer.dart';
import '../widgets/hymn_list_view.dart';
import '../model/hymn.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = "/favorites_screen";

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ScrollController _favscroll = ScrollController();
  bool init = true;

  @override
  Widget build(BuildContext context) {
    HymnBookProvider hymnData =
        Provider.of<HymnBookProvider>(context, listen: true);
    List<Hymn> favoriteHymnList = hymnData.favHymnList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAVORITES'),
      ),
      drawer: MainDrawer(),
      body: favoriteHymnList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RawScrollbar(
                  thumbColor: Theme.of(context).secondaryHeaderColor,
                  thumbVisibility: false,
                  trackVisibility: false,
                  interactive: true,
                  controller: _favscroll,
                  radius: Radius.circular(4),
                  thickness: 10,
                  child: HymnListView(
                    hymnList: favoriteHymnList,
                    scroll: _favscroll,
                    wholeProv: false,
                  )),
            )
          : Center(
              child: Text('No Favorites added'),
            ),
    );
  }
}
