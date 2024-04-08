import 'package:church/features/hymn/presentation/components/hymn_grid_view.dart';
import 'package:church/features/hymn/presentation/components/hymn_list_view.dart';
import 'package:church/model/hymn.dart';
import 'package:flutter/material.dart';

class DisplayedHymnList extends StatelessWidget {
  final List<HymnNotifier> foundHymns;
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
                    ? Semantics(
                        label: "Portrait view",
                        child:
                            HymnListView(hymnList: foundHymns, scroll: scroll))
                    : Semantics(
                        label: "Landscape view",
                        child:
                            HymnGridView(hymnList: foundHymns, scroll: scroll));
              }))
          : Text(
              'No results found',
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
    );
  }
}
