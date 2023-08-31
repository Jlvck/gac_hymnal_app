import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/hymn.dart';
import '../providers/hymn_book_provider.dart';
import '../screens/hymn_view_screen.dart';

class HymnListView extends StatelessWidget {
  final List<Hymn> hymnList;

  final ScrollController scroll;

  final bool wholeProv;

  const HymnListView(
      {super.key,
      required this.hymnList,
      required this.scroll,
      required this.wholeProv});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(2),
      controller: scroll,
      physics: const BouncingScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      semanticChildCount: hymnList.length,
      itemExtent: 60,
      children: List.generate(hymnList.length, growable: true, (index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(HymnViewScreen.routeName,
                arguments: hymnList[index]);
          },
          child: ChangeNotifierProvider.value(
            value: hymnList[index],
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              height: 60,
              child: Card(
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  minLeadingWidth: 40,
                  horizontalTitleGap: 0,
                  leading: CircleAvatar(
                    radius: 15,
                    child: FittedBox(
                      child: Text(
                        hymnList[index].id,
                        softWrap: false,
                      ),
                    ),
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
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: () {
                        Provider.of<HymnBookProvider>(context, listen: false)
                            .checkfav(hymnIcon.id, context);
                        hymnIcon.toggleFav();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
