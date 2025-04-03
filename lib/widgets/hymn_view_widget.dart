// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

import './hymn_verses_widget.dart';
import './hymn_chorus_widget.dart';

import '../model/language_item.dart';

class HymnViewWidget extends StatefulWidget {
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
  State<HymnViewWidget> createState() => _HymnViewWidgetState();
}

class _HymnViewWidgetState extends State<HymnViewWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late List<Animation<double>> _animations;

  late int _animationLength;

  bool _amenAnimation = false;

  final Duration _amenDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationLength = widget.hymnYorubaVerses.length;
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animations = List.generate(_animationLength, (index) {
      return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(((index + 0.1) / (_animationLength + 0.1)) / 2, 1,
              curve: Curves.easeOut)));
    });
    _controller.forward().then((last) {
      setState(() {
        _amenAnimation = true;
      });
    });
  }

  @override
  void didUpdateWidget(covariant HymnViewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.hymnYorubaVerses.length != widget.hymnYorubaVerses.length) {
      setState(() {
        _animationLength = widget.hymnYorubaVerses.length;

        _animations = List.generate(_animationLength, (index) {
          return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
              parent: _controller,
              curve: Interval(((index + 0.1) / (_animationLength + 0.1)) / 2, 1,
                  curve: Curves.easeOut)));
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    List<List<String>> currentHymn = currentLanguage == LanguageItem.yoruba
        ? widget.hymnYorubaVerses
        : widget.hymnEnglishVerses;
    List<String>? currentChorus = currentLanguage == LanguageItem.yoruba
        ? widget.hymnYorubaChorus
        : widget.hymnEnglishChorus;
    double maxHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;
    return SizedBox(
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
                      AnimatedOpacity(
                        duration: _amenDuration,
                        opacity: _amenAnimation ? 1.0 : 0.0,
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),

                      //Hymn Verse of the Hymn
                      FadeTransition(
                        opacity: _animations[index],
                        child: HymnVersesWidget(
                          currentVerse: currentHymn[index],
                        ),
                      ),
                      if (widget.hymnYorubaChorus != null &&
                          widget.hymnEnglishChorus != null)
                        AnimatedOpacity(
                          duration: _amenDuration,
                          opacity: _amenAnimation ? 1.0 : 0.0,
                          child: Text(
                            currentLanguage == LanguageItem.yoruba
                                ? 'Ègbè'
                                : 'Chorus',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                        ),

                      //Chorus if available
                      if (widget.hymnYorubaChorus != null &&
                          widget.hymnEnglishChorus != null)
                        FadeTransition(
                            opacity: _animations[index],
                            child:
                                HymnChorusWidget(currentChorus: currentChorus!))
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
            child: AnimatedOpacity(
              duration: _amenDuration,
              opacity: _amenAnimation ? 1.0 : 0.0,
              child: SizedBox(
                child: Text(
                  currentLanguage == LanguageItem.yoruba
                      ? "Amin..."
                      : "Amen...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
