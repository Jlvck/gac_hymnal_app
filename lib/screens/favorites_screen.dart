// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:church/providers/hymn_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import '../widgets/hymn_list_view.dart';
import '../providers/hymn.dart';
import '../providers/hymn.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = "/favorites_screen";
  final ScrollController _favscroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Hymn> favoriteHymnList = Provider.of<HymnBook>(context).favHymnList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAVORITES'),
      ),
      drawer: MainDrawer(),
      body: favoriteHymnList.isNotEmpty
          ? RawScrollbar(
              thumbColor: Colors.red,
              thumbVisibility: false,
              trackVisibility: false,
              interactive: true,
              controller: _favscroll,
              radius: Radius.circular(4),
              thickness: 10,
              child: HymnListView(
                hymnList: favoriteHymnList,
                scroll: _favscroll,
              ))
          : Center(
              child: Text('No Favorites added'),
            ),
    );
  }
}
