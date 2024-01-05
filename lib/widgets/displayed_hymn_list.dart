import 'package:flutter/material.dart';
import 'package:church/model/hymn.dart';
import '../widgets/hymn_list_view.dart';
import '../widgets/hymn_grid_view.dart';

class DisplayedHymnList extends StatelessWidget {
  final List<Hymn> foundHymns;
  final ScrollController scroll;
  const DisplayedHymnList(
      {super.key, required this.foundHymns, required this.scroll});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: foundHymns.isNotEmpty
          ? Scrollbar(
              thumbVisibility: false,
              trackVisibility: false,
              interactive: true,
              controller: scroll,
              radius: const Radius.circular(4),
              thickness: 10,
              child: OrientationBuilder(builder: (context, orientation) {
                return orientation == Orientation.portrait
                    ? HymnListView(hymnList: foundHymns, scroll: scroll)
                    : HymnGridView(hymnList: foundHymns, scroll: scroll);
              }))
          : const Text(
              'No results found',
              style: TextStyle(fontSize: 24),
            ),
    );
  }
}
