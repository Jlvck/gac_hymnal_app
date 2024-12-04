import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/hymn_book_provider.dart';
import '../providers/language_provider.dart';

import '../widgets/language_popup_menu.dart';
import '../widgets/hymn_view_widget.dart';

import '../model/hymn.dart';
import '../model/language_item.dart';

class HymnViewScreen extends StatefulWidget {
  static const String routeName = "/hymn_view";
  final String id;

  const HymnViewScreen({
    super.key,
    required this.id,
  });

  @override
  State<HymnViewScreen> createState() => _HymnViewScreenState();
}

class _HymnViewScreenState extends State<HymnViewScreen>
    with WidgetsBindingObserver {
  late List<Hymn> hymnList;
  final Duration _colorDuration = Duration(milliseconds: 100);
  double widthFactor = 0.2;
  double factorTrigger = 0.3;
  late ScrollController controller;
  ValueNotifier<bool> colorChange = ValueNotifier(false);
  ValueNotifier<bool> ignoreTouch = ValueNotifier(false);
  late double screenWidth;
  late double leftScrollExtent;

  int pageNumber = 0;

  double oldOffset = 0.0;
  @override
  void initState() {
    print("init");
    pageNumber = int.tryParse(widget.id) != null ? int.parse(widget.id) - 1 : 0;
    hymnList = Provider.of<HymnBookProvider>(context, listen: false).hymnList;

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    print("did change dependencies");
    MediaQueryData mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    leftScrollExtent = screenWidth * widthFactor;

    controller = ScrollController(
        initialScrollOffset: leftScrollExtent, keepScrollOffset: false);
    super.didChangeDependencies();
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics

    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.animateTo(widthFactor * MediaQuery.of(context).size.width,
          duration: Duration(microseconds: 1), curve: Curves.easeInOut);

      print("moved to set offset");
    });
  }

  @override
  void dispose() {
    controller.dispose();
    ignoreTouch.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool checkLeftSideExtent(double offset) {
    return offset <= (factorTrigger * leftScrollExtent);
  }

  bool checkRightSideExtent(double offset) {
    return offset >=
        ((leftScrollExtent * 2) - (factorTrigger * leftScrollExtent));
  }

  @override
  Widget build(BuildContext context) {
    print("Build");

    List<Widget> list = <Widget>[
      SizedBox(
          width: leftScrollExtent,
          child: pageNumber == 0
              ? null
              : UnconstrainedBox(
                  alignment: Alignment.centerRight,
                  child: ValueListenableBuilder(
                      valueListenable: colorChange,
                      child: Center(
                          child: Text(
                        "$pageNumber",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                      builder: (context, colorLeft, child) {
                        return AnimatedContainer(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: colorLeft &&
                                        checkLeftSideExtent(controller.offset)
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).colorScheme.tertiary,
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            duration: _colorDuration,
                            curve: Curves.easeInOut,
                            child: child);
                      }),
                )),
      GestureDetector(
        onHorizontalDragEnd: (details) {
          if (controller.offset < leftScrollExtent) {
            final double currentOffset = controller.offset;

            ignoreTouch.value = true;
            colorChange.value = false;

            controller
                .animateTo(leftScrollExtent,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut)
                .then(
              (value) {
                if (checkLeftSideExtent(currentOffset) && pageNumber != 0) {
                  setState(() {
                    pageNumber = pageNumber - 1;
                  });

                  ignoreTouch.value = false;
                } else {
                  ignoreTouch.value = false;
                }
              },
            );
          } else if (controller.offset > leftScrollExtent) {
            final double currentOffset = controller.offset;

            ignoreTouch.value = true;
            colorChange.value = false;

            controller
                .animateTo(leftScrollExtent,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut)
                .then(
              (value) {
                if (checkRightSideExtent(currentOffset) &&
                    pageNumber != (499)) {
                  setState(() {
                    pageNumber = pageNumber + 1;
                  });

                  ignoreTouch.value = false;
                } else {
                  ignoreTouch.value = false;
                }
              },
            );
          } else {
            ignoreTouch.value = false;
          }
        },
        onHorizontalDragUpdate: (details) {
          final double offset = controller.offset;
          if (checkLeftSideExtent(offset) || checkRightSideExtent(offset)) {
            if (colorChange.value != true) {
              colorChange.value = true;
              HapticFeedback.lightImpact();
            }
          } else {
            if (colorChange.value != false) {
              colorChange.value = false;
              HapticFeedback.lightImpact();
            }
          }
          controller.jumpTo(controller.position.pixels - details.delta.dx);
        },
        child: HymnViewWidget(
          hymnYorubaVerses: hymnList[pageNumber].versesYoruba,
          hymnEnglishVerses: hymnList[pageNumber].versesEnglish,
          hymnEnglishChorus: hymnList[pageNumber].chorusEnglish,
          hymnYorubaChorus: hymnList[pageNumber].chorusYoruba,
        ),
      ),
      SizedBox(
          width: leftScrollExtent,
          child: pageNumber == (hymnList.length - 1)
              ? null
              : UnconstrainedBox(
                  alignment: Alignment.centerLeft,
                  child: ValueListenableBuilder(
                      valueListenable: colorChange,
                      child: Center(
                          child: Text(
                        "${pageNumber + 2}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                      builder: (context, colorRight, child) {
                        return AnimatedContainer(
                            duration: _colorDuration,
                            curve: Curves.easeInOut,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: colorRight &&
                                        checkRightSideExtent(controller.offset)
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).colorScheme.tertiary,
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            child: child);
                      }),
                )),
    ];
    return Semantics(
      label: "Hymn Number ${hymnList[pageNumber].id}",
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.fill,
            child: Text(
              checkAppBarTitle(context, hymnList[pageNumber].id),
              softWrap: true,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          elevation: 0,
          actions: [
            ChangeNotifierProvider.value(
              value: hymnList[pageNumber],
              child: Consumer<Hymn>(
                builder: (ctx, hymnIcon, _) => IconButton(
                  icon: Icon(hymnIcon.isFavorites
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Theme.of(context).secondaryHeaderColor,
                  onPressed: () {
                    hymnIcon.toggleFav();
                    Provider.of<HymnBookProvider>(context, listen: false)
                        .checkfav(hymnIcon.id, context);
                  },
                ),
              ),
            ),
            const LanguagePopUpMenu()
          ],
        ),
        body: Builder(builder: (context) {
          return ValueListenableBuilder(
              valueListenable: ignoreTouch,
              child: ListView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.hardEdge,
                physics: NeverScrollableScrollPhysics(),
                children: [...list],
              ),
              builder: (context, ignore, child) {
                return IgnorePointer(ignoring: ignore, child: child);
              });
        }),
      ),
    );
  }

  String checkAppBarTitle(BuildContext context, String id) {
    LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    if (currentLanguage == LanguageItem.yoruba) {
      return 'Iwe Orin $id';
    } else {
      return 'Hymn $id';
    }
  }
}
