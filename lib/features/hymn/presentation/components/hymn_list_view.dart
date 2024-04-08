import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../model/hymn.dart';
import '../model/language_item.dart';
import '../providers/hymn_book_provider.dart';
import '../providers/language_provider.dart';
import '../features/hymn/presentation/screens/hymn_view_screen.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 0),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        controller: scroll,
        physics: const BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        semanticChildCount: hymnList.length,
        itemExtent: 50,
        children: List.generate(hymnList.length, growable: true, (index) {
          return Semantics(
            label: "Hymn number ${index + 1}",
            child: Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  height: double.maxFinite,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              childCurrent: this,
                              child: HymnViewScreen(
                                id: hymnList[index].id,
                              ),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300)));
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      tileColor: Theme.of(context).colorScheme.background,
                      selectedColor: Theme.of(context).colorScheme.background,
                      isThreeLine: false,
                      dense: true,
                      horizontalTitleGap: 10,
                      minVerticalPadding: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      minLeadingWidth: 50,
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6)),
                          color: Theme.of(context).primaryColor,
                        ),
                        height: double.maxFinite,
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
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onBackground),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Semantics(
                        label: "Favorite button",
                        child: ChangeNotifierProvider.value(
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
                )),
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
