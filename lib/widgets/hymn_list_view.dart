import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/hymn.dart';
import '../model/language_item.dart';
import '../providers/hymn_book_provider.dart';
import '../providers/language_provider.dart';
import '../screens/hymn_view_screen.dart';

class HymnListView extends StatelessWidget {
  final List<Hymn> hymnList;

  final ScrollController scroll;

  const HymnListView({
    super.key,
    required this.hymnList,
    required this.scroll,
  });

  @override
  Widget build(BuildContext context) {
    print('build list_view context');
    return Card(
      margin: const EdgeInsets.only(left: 4, right: 4, top: 0),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 0),
        child: ListView(
          padding: const EdgeInsets.only(bottom: 5, top: 1),
          controller: scroll,
          physics: const BouncingScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          semanticChildCount: hymnList.length,
          itemExtent: 50,
          children: List.generate(hymnList.length, growable: true, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          // ignore: prefer_const_constructors
                          builder: (t) => HymnViewScreen(
                            id: hymnList[index].id,
                          ),
                        ))
                    .then((value) =>
                        Provider.of<HymnBookProvider>(context, listen: false)
                            .notify());
              },
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  height: double.maxFinite,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    isThreeLine: false,
                    dense: true,
                    horizontalTitleGap: 10,
                    minVerticalPadding: 2,
                    minLeadingWidth: 50,
                    titleAlignment: ListTileTitleAlignment.center,
                    tileColor: Colors.white,
                    leading: Container(
                      color: Theme.of(context).primaryColor,
                      height: double.maxFinite,
                      // margin: EdgeInsets.all(2),
                      padding: const EdgeInsets.all(2),
                      width: 50,
                      child: Center(
                        child: FittedBox(
                          child: Text(hymnList[index].id,
                              softWrap: false,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    title: Text(
                      checkTitle(context, index),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: ChangeNotifierProvider.value(
                      value: hymnList[index],
                      child: Consumer<Hymn>(
                        builder: (ctxx, hymnIcon, _) => IconButton(
                          padding: const EdgeInsets.only(left: 0),
                          icon: Icon(
                            hymnIcon.isFavorites
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          color: Theme.of(context).secondaryHeaderColor,
                          onPressed: () {
                            Provider.of<HymnBookProvider>(context,
                                    listen: false)
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
        ),
      ),
    );
  }

  String checkTitle(BuildContext context, int index) {
    LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    if (currentLanguage == LanguageItem.yoruba) {
      return hymnList[index].versesYoruba[0][0];
    } else {
      return hymnList[index].versesEnglish[0][0];
    }
  }
}
