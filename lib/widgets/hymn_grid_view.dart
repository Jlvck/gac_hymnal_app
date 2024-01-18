// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Theme.of(context).colorScheme.background),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            height: 110,
            child: InkWell(
              onTap: () {
                Navigator.push(
                        context,
                        PageTransition(
                            childCurrent: this,
                            child: HymnViewScreen(
                              id: hymnList[index].id,
                            ),
                            type: PageTransitionType.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 300)))
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
                            right: 10, left: 10, bottom: 0, top: 2),
                        child: Text(
                          checkTitle(context, index),
                          // textScaler: TextScaler.noScaling,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
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
