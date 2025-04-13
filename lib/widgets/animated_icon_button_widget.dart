import 'package:flutter/material.dart';
import 'package:gac_hymnal_app/providers/hymn_book_provider.dart';
import 'package:provider/provider.dart';

import '../model/hymn.dart';

class AnimatedIconButtonWidget extends StatelessWidget {
  final Hymn hymn;
  final Animation<double> animation;

  const AnimatedIconButtonWidget(
      {super.key, required this.hymn, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Favorite Button',
      child: ChangeNotifierProvider.value(
        value: hymn,
        child: Consumer<Hymn>(
          builder: (ctx, hymnIcon, _) => AnimatedBuilder(
              animation: animation,
              builder: (context, scale) {
                return IconButton(
                  // padding: const EdgeInsets.only(left: 0),
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    hymnIcon.isFavorites
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  color: Theme.of(context).secondaryHeaderColor,
                  iconSize: hymnIcon.isFavorites ? animation.value : 24.0,
                  onPressed: () {
                    Provider.of<HymnBookProvider>(context, listen: false)
                        .checkfav(hymnIcon.id, context);
                    hymnIcon.toggleFav();
                  },
                );
              }),
        ),
      ),
    );
  }
}
