// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/hymn_view_widget.dart';
import '../providers/hymn_book.dart';

import '../providers/hymn.dart';

class HymnViewScreen extends StatelessWidget {
  static const routeName = '/hymn_view';

  Widget versesWidget(List<List<String>> verses, int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      primary: false,
      itemBuilder: (ctxx, i) => Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            verses[index][i],
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      itemCount: verses[index].length,
    );
  }

  Widget chorusWidget(List<String> chorus) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Chorus",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontStyle: FontStyle.italic),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            primary: false,
            itemBuilder: (ctxx, t) => Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  chorus[t],
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            itemCount: chorus.length,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    double maxHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;

    final routeHymn = ModalRoute.of(context)!.settings.arguments as Hymn;

    final String routeTitle = routeHymn.verses[0][0];

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: Icon(Icons.arrow_back)),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "${routeHymn.id}: $routeTitle",
            softWrap: true,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
          ),
        ),
        elevation: 0,
        actions: [
          ChangeNotifierProvider.value(
            value: routeHymn,
            child: Consumer<Hymn>(
              builder: (ctx, hymnIcon, _) => IconButton(
                icon: Icon(hymnIcon.isFavorites
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Colors.red,
                onPressed: () {
                  hymnIcon.toggleFav();
                  Provider.of<HymnBook>(context, listen: false).changeFavBut();
                },
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
          width: maxWidth,
          height: maxHeight,
          child: HymnViewWidget(
            hymnVerses: routeHymn.verses,
            hymnChorus: routeHymn.chorus,
            isChorus: routeHymn.isChorus,
          )),
      backgroundColor: Colors.white,
    );
  }
}
