import 'package:flutter/material.dart';

class HymnViewWidget extends StatelessWidget {
  final List<List<String>> hymnVerses;
  final List<String> hymnChorus;
  final bool isChorus;

  const HymnViewWidget(
      {super.key,
      required this.hymnVerses,
      required this.hymnChorus,
      required this.isChorus});

  Widget versesWidget(List<String> verseNumber) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      children: List.generate(verseNumber.length, (i) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              verseNumber[i],
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }),
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
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: List.generate(chorus.length, (index) {
              return Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    chorus[index],
                    style: const TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: List.generate(hymnVerses.length, (index) {
            return Align(
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
                    versesWidget(
                      hymnVerses[index],
                    ),
                    if (isChorus) chorusWidget(hymnChorus)
                  ],
                ),
              ),
            );
          }),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text(
              'Amin....',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  fontStyle: FontStyle.italic),
            ),
          ),
        )
      ],
    );
  }
}
