// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hymn.dart';
import '../providers/hymn_book.dart';
import '../screens/hymn_view_screen.dart';

class HymnListView extends StatelessWidget {
  final List<Hymn> hymnList;

  final ScrollController scroll;

  final bool wholeProv;
  // ignore: prefer_const_constructors_in_immutables
  HymnListView(
      {required this.hymnList, required this.scroll, required this.wholeProv});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(2),
        controller: scroll,
        physics: const BouncingScrollPhysics(),
        itemExtent: 60,
        itemBuilder: (ctx, index) => GestureDetector(
              onTap: () {
                // final Hymn selectedHymn =
                //     Provider.of<HymnBook>(context, listen: false)
                //         .getHymn(hymnList[index].id);
                Navigator.of(context).pushNamed(HymnViewScreen.routeName,
                    arguments: hymnList[index]);
              },
              child: ChangeNotifierProvider.value(
                value: hymnList[index],
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      minLeadingWidth: 40,
                      horizontalTitleGap: 0,
                      leading: CircleAvatar(
                        child: FittedBox(
                          child: Text(
                            hymnList[index].id,
                            softWrap: false,
                          ),
                        ),
                        radius: 15,
                      ),
                      title: Text(
                        "${hymnList[index].verses[0][0]} ",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Consumer<Hymn>(
                        builder: (ctxx, hymnIcon, _) => IconButton(
                          padding: const EdgeInsets.only(left: 0),
                          icon: Icon(
                            hymnIcon.isFavorites
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          color: Colors.red,
                          onPressed: () {
                            Provider.of<HymnBook>(context, listen: false)
                                .checkfav(hymnIcon.id);
                            hymnIcon.toggleFav();
                            if (wholeProv) {
                              Provider.of<HymnBook>(context, listen: false)
                                  .changeFavBut();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        itemCount: hymnList.length);
  }
}
