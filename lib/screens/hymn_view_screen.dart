import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/hymn_book_provider.dart';
import '../widgets/hymn_view_widget.dart';

import '../model/hymn.dart';

class HymnViewScreen extends StatefulWidget {
  final String id;
  const HymnViewScreen({
    super.key,
    required this.id,
  });

  // ignore: prefer_typing_uninitialized_variables

  // ignore: use_key_in_widget_constructors

  @override
  State<HymnViewScreen> createState() => _HymnViewScreenState();
}

class _HymnViewScreenState extends State<HymnViewScreen> {
  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: int.parse(widget.id) - 1);
    List<Hymn> hymnList = Provider.of<HymnBookProvider>(context).hymnList;

    Hymn routeHymn =
        Provider.of<HymnBookProvider>(context, listen: true).getHymn(widget.id);

    Hymn widgetHymn = routeHymn;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.centerRight,
            child: Text(
              "Hymn ${widgetHymn.id}",
              softWrap: true,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        elevation: 0,
        actions: [
          ChangeNotifierProvider.value(
            value: widgetHymn,
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
          )
        ],
      ),
      body: PageView(
        onPageChanged: (value) {
          int newvalue = value + 1;
          print(newvalue);
          setState(() {
            Hymn newrouteHymn =
                Provider.of<HymnBookProvider>(context, listen: false)
                    .getHymn(newvalue.toString());
            widgetHymn = newrouteHymn;
            print(widgetHymn.isFavorites);
          });
        },
        controller: controller,
        children: List.generate(500, (index) {
          return HymnViewWidget(
              hymnVerses: hymnList[index].verses,
              hymnChorus: hymnList[index].chorus,
              isChorus: hymnList[index].isChorus);
        }),
      ),
      backgroundColor: Colors.white,
    );
  }
}
