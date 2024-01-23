import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/hymn_book_provider.dart';
import '../widgets/language_popup_menu.dart';
import '../widgets/drawer.dart';
import '../widgets/hymn_list_view.dart';
import '../widgets/hymn_grid_view.dart';
import '../model/hymn.dart';
import '../widgets/toggle_theme_switch.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = "/favorites_screen";

  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  static const screenName = 'Favorites';
  final ScrollController _favscroll = ScrollController();
  bool init = true;

  @override
  Widget build(BuildContext context) {
    List<Hymn> favoriteHymnList =
        Provider.of<HymnBookProvider>(context, listen: true).favHymnList;
    return Semantics(
      label: "Favorites Screen",
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            screenName,
            overflow: TextOverflow.visible,
          ),
          actions: const [ToggleThemeSwitch(), LanguagePopUpMenu()],
        ),
        drawer: MainDrawer(),
        body: favoriteHymnList.isNotEmpty
            ? RawScrollbar(
                thumbColor: Theme.of(context).secondaryHeaderColor,
                thumbVisibility: false,
                trackVisibility: false,
                interactive: true,
                controller: _favscroll,
                radius: const Radius.circular(4),
                thickness: 10,
                child: OrientationBuilder(builder: (context, orientation) {
                  return orientation == Orientation.portrait
                      ? HymnListView(
                          hymnList: favoriteHymnList, scroll: _favscroll)
                      : HymnGridView(
                          hymnList: favoriteHymnList, scroll: _favscroll);
                }))
            : Center(
                child: Text(
                  'No Favorites added',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
      ),
    );
  }
}
