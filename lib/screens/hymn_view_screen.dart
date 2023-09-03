import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/hymn_book_provider.dart';
import '../widgets/hymn_view_widget.dart';

import '../model/hymn.dart';

class HymnViewScreen extends StatefulWidget {
  static const routeName = '/hymn_view';

  const HymnViewScreen({super.key});

  @override
  State<HymnViewScreen> createState() => _HymnViewScreenState();
}

Widget _buttonWidget(
  IconData icon,
  BuildContext context,
  String id,
) {
  return InkWell(
    onTap: () {
      icon == Icons.chevron_left
          ? _moveLeft(context, id)
          : _moveRight(context, id);
    },
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 40,
      ),
    ),
  );
}

void _moveRight(BuildContext context, String id) {
  var idNumber = int.parse(id) + 1;
  Navigator.of(context).pushReplacementNamed(HymnViewScreen.routeName,
      arguments: Provider.of<HymnBookProvider>(context, listen: false)
          .getHymn(idNumber.toString()));
}

void _moveLeft(BuildContext context, String id) {
  var idNumber = int.parse(id) - 1;
  Navigator.of(context).pushReplacementNamed(HymnViewScreen.routeName,
      arguments: Provider.of<HymnBookProvider>(context, listen: false)
          .getHymn(idNumber.toString()));
}

class _HymnViewScreenState extends State<HymnViewScreen> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    double maxHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;

    Hymn routeHymn = ModalRoute.of(context)!.settings.arguments as Hymn;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.centerRight,
            child: Text(
              "Hymn ${routeHymn.id}",
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
            value: routeHymn,
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
      body: SizedBox(
          width: maxWidth,
          height: maxHeight,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.primaryDelta! > 0) {
                if (routeHymn.id != '1') {
                  _moveLeft(context, routeHymn.id);
                }
              } else {
                if (routeHymn.id != '500') {
                  _moveRight(context, routeHymn.id);
                }
              }
            },
            child: ListView(children: [
              HymnViewWidget(
                hymnVerses: routeHymn.verses,
                hymnChorus: routeHymn.chorus,
                isChorus: routeHymn.isChorus,
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Amin....',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: routeHymn.id == '1' ? false : true,
                      replacement: SizedBox.fromSize(
                        size: const Size.fromWidth(50),
                      ),
                      child: _buttonWidget(
                          Icons.chevron_left, context, routeHymn.id),
                    ),
                    Visibility(
                      visible: routeHymn.id == '500' ? false : true,
                      replacement: SizedBox.fromSize(
                        child: SizedBox.fromSize(
                          size: const Size.fromWidth(50),
                        ),
                      ),
                      child: _buttonWidget(
                          Icons.chevron_right, context, routeHymn.id),
                    ),
                  ],
                ),
              )
            ]),
          )),
      backgroundColor: Colors.white,
    );
  }
}
