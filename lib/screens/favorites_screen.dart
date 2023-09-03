import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hymn_book_provider.dart';
import '../widgets/drawer.dart';
import '../widgets/hymn_list_view.dart';
import '../model/hymn.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = "/favorites_screen";

  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ScrollController _favscroll = ScrollController();
  bool init = true;

  @override
  Widget build(BuildContext context) {
    List<Hymn> favoriteHymnList =
        Provider.of<HymnBookProvider>(context, listen: true).favHymnList;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAVORITES',
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
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
                  radius: const Radius.circular(4),
                  thickness: 10,
                  child: HymnListView(
                    hymnList: favoriteHymnList,
                    scroll: _favscroll,
                  )),
            )
          : const Center(
              child: Text('No Favorites added'),
            ),
    );
  }
}
