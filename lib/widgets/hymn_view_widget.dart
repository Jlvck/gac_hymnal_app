// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

import '../model/language_item.dart';

class HymnViewWidget extends StatelessWidget {
  final List<List<String>> hymnYorubaVerses;
  final List<String>? hymnYorubaChorus;
  final List<List<String>> hymnEnglishVerses;
  final List<String>? hymnEnglishChorus;

  const HymnViewWidget({
    super.key,
    required this.hymnYorubaVerses,
    this.hymnYorubaChorus,
    required this.hymnEnglishVerses,
    this.hymnEnglishChorus,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    double maxHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;
    print('build hymn view widget');

    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(color: Colors.black, width: 1))),
      height: maxHeight,
      width: maxWidth,
      child: ListView(padding: EdgeInsets.zero, children: [
        ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: List.generate(checkLength(context), (index) {
            return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "${index + 1}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    checkVerses(context, index),
                    if (hymnYorubaChorus != null && hymnEnglishChorus != null)
                      checkChorus(context)
                  ],
                ),
              ),
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              checkAmen(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ]),
    );
  }

  Widget versesWidget(List<String> verseNumber) {
    return ListView(
      clipBehavior: Clip.hardEdge,
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

  int checkLength(BuildContext context) {
    LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    if (currentLanguage == LanguageItem.yoruba) {
      return hymnYorubaVerses.length;
    } else {
      return hymnEnglishVerses.length;
    }
  }

  String checkAmen(BuildContext context) {
    LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    if (currentLanguage == LanguageItem.yoruba) {
      return 'Amin....';
    } else {
      return 'Amen...';
    }
  }

  checkVerses(BuildContext context, int index) {
    LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    if (currentLanguage == LanguageItem.yoruba) {
      return versesWidget(hymnYorubaVerses[index]);
    } else {
      return versesWidget(hymnEnglishVerses[index]);
    }
  }

  checkChorus(BuildContext context) {
    LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    if (currentLanguage == LanguageItem.yoruba) {
      return chorusWidget(hymnYorubaChorus!);
    } else {
      return chorusWidget(hymnEnglishChorus!);
    }
  }
}
