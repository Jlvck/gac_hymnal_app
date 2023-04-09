// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HymnView extends StatelessWidget {
  static const routeName = '/hymn_view';

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    double maxHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;

    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final String routeTitle = routeArgs['title'];
    final List routeHymn = routeArgs['hymn'];

    return Scaffold(
        appBar: AppBar(title: Text(routeTitle.toUpperCase())),
        body: SizedBox(
          height: maxHeight,
          width: maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemBuilder: (ctx, index) => Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(routeHymn[index]),
                ),
              ),
              itemCount: routeHymn.length,
            ),
          ),
        ));
  }
}
