// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

import './hymn_verses_widget.dart';
import './hymn_chorus_widget.dart';

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
    final LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    List<List<String>> currentHymn = currentLanguage == LanguageItem.yoruba
        ? hymnYorubaVerses
        : hymnEnglishVerses;
    List<String>? currentChorus = currentLanguage == LanguageItem.yoruba
        ? hymnYorubaChorus
        : hymnEnglishChorus;
    double maxHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(color: Colors.black, width: 0.5))),
      height: maxHeight,
      width: maxWidth,
      child: ListView(padding: EdgeInsets.zero, children: [
        ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: List.generate(
            currentHymn.length,
            (index) {
              return Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      //Hymn Verse Number
                      Text(
                        "${index + 1}",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      //Hymn Verse of the Hymn
                      HymnVersesWidget(
                        currentVerse: currentHymn[index],
                      ),
                      //Chorus if available
                      if (hymnYorubaChorus != null && hymnEnglishChorus != null)
                        HymnChorusWidget(currentChorus: currentChorus!)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        //text for Amin or Amen depending on the current language choice
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              currentLanguage == LanguageItem.yoruba ? "Amin..." : "Amen...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        ),
      ]),
    );
  }
}
