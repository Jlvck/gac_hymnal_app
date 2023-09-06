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

  @override
  State<HymnViewScreen> createState() => _HymnViewScreenState();
}

class _HymnViewScreenState extends State<HymnViewScreen> {
  List<Hymn> hymnList = [];
  int pagenumber = 0;

  @override
  void initState() {
    hymnList = Provider.of<HymnBookProvider>(context, listen: false).hymnList;
    pagenumber = int.parse(widget.id) - 1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: int.parse(widget.id) - 1);

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.centerRight,
            child: Text(
              "Hymn ${hymnList[pagenumber].id}",
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
          )
        ],
      ),
      body: PageView(
        clipBehavior: Clip.hardEdge,
        onPageChanged: (value) {
          setState(() {
            pagenumber = value;
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
