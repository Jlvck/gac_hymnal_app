// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import './providers/hymn.dart';

class HymnView extends StatelessWidget {
  static const routeName = '/hymn_view';

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    double maxHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;

    final routeArgs = ModalRoute.of(context).settings.arguments as Hymn;

    final String routeTitle = routeArgs.verses[0][0];
    final List<List<String>> routeHymn = routeArgs.verses;

    return Scaffold(
        appBar:
            AppBar(title: Text("${routeArgs.id}:${routeTitle.toUpperCase()}")),
        body: SingleChildScrollView(
          child: SizedBox(
            height: maxHeight,
            width: maxWidth,
            child: ListView.builder(
              itemBuilder: (ctx, index) => Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "${index + 1}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        primary: false,
                        itemBuilder: (ctxx, i) => Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              routeHymn[index][i],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        itemCount: routeHymn[index].length,
                      ),
                      if (routeArgs.isChorus)
                        Container(
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
                                physics: ClampingScrollPhysics(),
                                primary: false,
                                itemBuilder: (ctxx, t) => Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      routeArgs.chorus[t],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                itemCount: routeArgs.chorus.length,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              itemCount: routeHymn.length,
            ),
          ),
        ));
  }
}
