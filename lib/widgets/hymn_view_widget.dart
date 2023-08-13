// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class HymnViewWidget extends StatelessWidget {
  final List<List<String>> hymnVerses;
  final List<String> hymnChorus;
  final bool isChorus;

  // ignore: prefer_const_constructors_in_immutables
  HymnViewWidget(
      {required this.hymnVerses,
      required this.hymnChorus,
      required this.isChorus});

  Widget versesWidget(List<List<String>> verses, int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      itemBuilder: (ctxx, i) => Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            verses[index][i],
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      itemCount: verses[index].length,
    );
  }

  Widget chorusWidget(List<String> chorus) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Chorus",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontStyle: FontStyle.italic),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            itemBuilder: (ctxx, t) => Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  chorus[t],
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
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
    return ListView(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (ctx, index) => Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "${index + 1}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  versesWidget(hymnVerses, index),
                  if (isChorus) chorusWidget(hymnChorus)
                ],
              ),
            ),
          ),
          itemCount: hymnVerses.length,
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text('Amen'),
        )
      ],
    );
  }
}
