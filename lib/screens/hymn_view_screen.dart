import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../providers/hymn_book_provider.dart';
import '../providers/language_provider.dart';

import '../widgets/language_popup_menu.dart';
import '../widgets/hymn_view_widget.dart';

import '../model/hymn.dart';
import '../model/language_item.dart';

class HymnViewScreen extends StatefulWidget {
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
  int pagenumber = 0;
  Hymn? presentHymn;

  @override
  void initState() {
    hymnList = Provider.of<HymnBookProvider>(context, listen: false).hymnList;
    pagenumber = int.parse(widget.id) - 1;
    presentHymn = Provider.of<HymnBookProvider>(context, listen: false)
        .getHymn(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: pagenumber);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            checkAppBarTitle(context, presentHymn!.id),
            softWrap: true,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        actions: [
          ChangeNotifierProvider.value(
            value: presentHymn,
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
      body: Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection direction) {},
          child: HymnViewWidget(
            hymnYorubaVerses: presentHymn!.versesYoruba,
            hymnYorubaChorus: presentHymn!.chorusYoruba,
            hymnEnglishVerses: presentHymn!.versesEnglish,
            hymnEnglishChorus: presentHymn!.chorusEnglish,
          )),
      backgroundColor: Colors.white,
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
