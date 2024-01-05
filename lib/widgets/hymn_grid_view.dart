// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/hymn.dart';
import '../model/language_item.dart';
import '../providers/hymn_book_provider.dart';
import '../providers/language_provider.dart';
import '../screens/hymn_view_screen.dart';

class HymnGridView extends StatelessWidget {
  final List<Hymn> hymnList;

  final ScrollController scroll;

  const HymnGridView({
    super.key,
    required this.hymnList,
    required this.scroll,
  });

  @override
  Widget build(BuildContext context) {
    print('build list_view context');
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 0),
      child: GridView(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        controller: scroll,
        physics: const BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        semanticChildCount: hymnList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 110,
        ),
        children: List.generate(hymnList.length, growable: true, (index) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.white),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            height: 110,
            child: InkWell(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (t) => HymnViewScreen(
                            id: hymnList[index].id,
                          ),
                        ))
                    .then((value) =>
                        Provider.of<HymnBookProvider>(context, listen: false)
                            .notify());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 2, top: 2),
                        child: Text(
                          checkTitle(context, index),
                          // textScaler: TextScaler.noScaling,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    padding: EdgeInsets.only(left: 10, right: 5),
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
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
                        ChangeNotifierProvider.value(
                          value: hymnList[index],
                          child: Consumer<Hymn>(
                            builder: (ctxx, hymnIcon, _) => IconButton(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerRight,
                              icon: Icon(
                                hymnIcon.isFavorites
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                applyTextScaling: false,
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
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
