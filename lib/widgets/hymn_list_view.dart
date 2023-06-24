// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hymn.dart';
import '../providers/hymn_book.dart';
import './hymn_view.dart';

class HymnListView extends StatelessWidget {
  final List<Hymn> hymnList;

  final ScrollController scroll;

  final bool wholeProv;
  // ignore: prefer_const_constructors_in_immutables
  HymnListView(
      {@required this.hymnList,
      @required this.scroll,
      @required this.wholeProv});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(2),
        controller: scroll,
        itemExtent: 60,
        itemBuilder: (ctx, index) => GestureDetector(
              onTap: () {
                final Hymn selectedHymn =
                    Provider.of<HymnBook>(context, listen: false)
                        .getHymn(hymnList[index].id);
                Navigator.of(context)
                    .pushNamed(HymnView.routeName, arguments: selectedHymn);
              },
              child: ChangeNotifierProvider.value(
                value: hymnList[index],
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(hymnList[index].id),
                        radius: 15,
                      ),
                      title: Text("${hymnList[index].verses[0][0]} "),
                      trailing: Consumer<Hymn>(
                        builder: (ctxx, hymnIcon, _) => IconButton(
                          icon: Icon(hymnIcon.isFavorites
                              ? Icons.favorite
                              : Icons.favorite_border),
                          color: Colors.red,
                          onPressed: () {
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
