// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import './hymn_data.dart';
import './hymn_view.dart';

class HymnCategory extends StatelessWidget {
  static const routeName = '/hymn_category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HYMNBOOK')),
      body: GridView(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: HYMNS
              .map(
                (e) => InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(HymnView.routeName),
                  child: Card(
                    elevation: 5.0,
                    child: FittedBox(
                        child: Center(child: Text(e['id'] as String))),
                  ),
                ),
              )
              .toList()),
    );
  }
}
