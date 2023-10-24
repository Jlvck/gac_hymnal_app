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

  // ignore: curly_braces_in_flow_control_structures
  String checkTitle(BuildContext context, int index) {
    LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    if (currentLanguage == LanguageItem.yoruba) {
      return hymnList[index].versesYoruba[0][0];
    } else {
      return hymnList[index].versesEnglish[0][0];
    }
  }

  @override
  Widget build(BuildContext context) {
    print('biuld context');
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
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            height: 60,
            child: Card(
              elevation: 5,
              child: ListTile(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                minLeadingWidth: 40,
                horizontalTitleGap: 0,
                tileColor: Colors.white,
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foregroundColor: Colors.white,
                  radius: 15,
                  child: FittedBox(
                    child: Text(
                      hymnList[index].id,
                      softWrap: false,
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
