import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/hymn_book_provider.dart';
import '../providers/language_provider.dart';

import '../widgets/language_popup_menu.dart';
import '../widgets/hymn_view_widget.dart';

import '../model/hymn.dart';
import '../model/language_item.dart';

class HymnViewScreen extends StatefulWidget {
  static const String routeName = "/hymn_view";
  final String id;
  const HymnViewScreen({
    super.key,
    required this.id,
  });

  @override
  State<HymnViewScreen> createState() => _HymnViewScreenState();
}

class _HymnViewScreenState extends State<HymnViewScreen> {
  List<Hymn> hymnList = [];
  int pagenumber = 1;
  late final PageController controller;
  bool changePage = false;
  @override
  void initState() {
    hymnList = Provider.of<HymnBookProvider>(context, listen: false).hymnList;

    controller = PageController(
      initialPage: pagenumber,
    );

    super.initState();

    controller.addListener(() {
      if ((changePage && (pagenumber != 1 && pagenumber == controller.page)) ||
          (controller.page == 2.0)) {
        controller
            .animateToPage(2,
                curve: Curves.easeInOut, duration: Duration(milliseconds: 200))
            .then(
          (value) {
            controller
                .animateToPage(1,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 200))
                .then(
              (value) {
                setState(() {
                  changePage = false;
                  pagenumber = 1;
                });
              },
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Hymn Number ${widget.id}",
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.fill,
            child: Text(
              checkAppBarTitle(context, hymnList[pagenumber].id),
              softWrap: true,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          elevation: 0,
          actions: [
            ChangeNotifierProvider.value(
              value: hymnList[pagenumber],
              child: Consumer<Hymn>(
                builder: (ctx, hymnIcon, _) => IconButton(
                  icon: Icon(hymnIcon.isFavorites
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Theme.of(context).secondaryHeaderColor,
                  onPressed: () {
                    hymnIcon.toggleFav();
                    Provider.of<HymnBookProvider>(context, listen: false)
                        .checkfav(hymnIcon.id, context);
                  },
                ),
              ),
            ),
            const LanguagePopUpMenu()
          ],
        ),
        body: PageView(
          clipBehavior: Clip.hardEdge,
          controller: controller,
          onPageChanged: (value) {
            print("Current page $value");
            setState(() {
              changePage = true;
              pagenumber = value;
            });
          },
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Text("1"),
            HymnViewWidget(
              hymnYorubaVerses: hymnList[pagenumber + 1].versesYoruba,
              hymnEnglishVerses: hymnList[pagenumber + 1].versesEnglish,
              hymnEnglishChorus: hymnList[pagenumber + 1].chorusEnglish,
              hymnYorubaChorus: hymnList[pagenumber + 1].chorusYoruba,
            ),
            Text("2")
          ],
        ),
      ),
    );
  }

  String checkAppBarTitle(BuildContext context, String id) {
    LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    if (currentLanguage == LanguageItem.yoruba) {
      return 'Iwe Orin $id';
    } else {
      return 'Hymn $id';
    }
  }
}
