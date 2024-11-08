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

class _HymnViewScreenState extends State<HymnViewScreen> {
  late Hymn currentHymn;
  final Duration _colorDuration = Duration(milliseconds: 100);
  double widthFactor = 0.2;
  double factorTrigger = 0.3;
  late ScrollController controller;
  bool colorChange = false;
  late double screenWidth;
  bool ignoreTouch = false;
  late double leftScrollExtent;
  late double rightScrollExtent;
  int pageNumber = 0;

  double oldOffset = 0.0;
  @override
  void initState() {
    pageNumber = int.tryParse(widget.id) != null ? int.parse(widget.id) - 1 : 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    currentHymn = Provider.of<HymnBookProvider>(context, listen: false)
        .getHymn(widget.id.toString());
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    leftScrollExtent = screenWidth * widthFactor;
    rightScrollExtent = screenWidth * widthFactor * 2;

    controller = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: leftScrollExtent,
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = <Widget>[
      SizedBox(
          width: leftScrollExtent,
          child: pageNumber == 0
              ? null
              : UnconstrainedBox(
                  alignment: Alignment.centerRight,
                  child: AnimatedContainer(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: colorChange ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      height: 50,
                      duration: _colorDuration,
                      curve: Curves.easeInOut,
                      child: Center(
                          child: Text(
                        "$pageNumber",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
                )),
      GestureDetector(
        onHorizontalDragEnd: (details) {
          if (controller.offset < leftScrollExtent) {
            final double currentOffset = controller.offset;
            setState(() {
              ignoreTouch = true;
            });

            controller
                .animateTo(leftScrollExtent,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut)
                .then(
              (value) {
                if (currentOffset <= (factorTrigger * leftScrollExtent) &&
                    pageNumber != 0) {
                  setState(() {
                    pageNumber = pageNumber - 1;

                    currentHymn =
                        Provider.of<HymnBookProvider>(context, listen: false)
                            .getHymn((pageNumber + 1).toString());

                    ignoreTouch = false;
                  });
                } else {
                  setState(() {
                    ignoreTouch = false;
                  });
                }
              },
            );
          } else if (controller.offset > leftScrollExtent) {
            final double currentOffset = controller.offset;
            setState(() {
              ignoreTouch = true;
            });

            controller
                .animateTo(leftScrollExtent,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut)
                .then(
              (value) {
                if (currentOffset >=
                        ((leftScrollExtent * 2) -
                            (factorTrigger * leftScrollExtent)) &&
                    pageNumber != (499)) {
                  setState(() {
                    pageNumber = pageNumber + 1;
                    currentHymn =
                        Provider.of<HymnBookProvider>(context, listen: false)
                            .getHymn((pageNumber + 1).toString());
                    ignoreTouch = false;
                  });
                } else {
                  setState(() {
                    ignoreTouch = false;
                  });
                }
              },
            );
          } else {
            setState(() {
              ignoreTouch = false;
            });
          }
        },
        onHorizontalDragUpdate: (details) {
          if (controller.offset <= (factorTrigger * leftScrollExtent) ||
              controller.offset >=
                  ((leftScrollExtent * 2) -
                      (factorTrigger * leftScrollExtent))) {
            setState(() {
              colorChange = true;
            });
            // HapticFeedback.lightImpact();
          } else {
            setState(() {
              colorChange = false;
            });
          }
          controller.jumpTo(controller.position.pixels - details.delta.dx);
        },
        child: HymnViewWidget(
          hymnYorubaVerses: currentHymn.versesYoruba,
          hymnEnglishVerses: currentHymn.versesEnglish,
          hymnEnglishChorus: currentHymn.chorusEnglish,
          hymnYorubaChorus: currentHymn.chorusYoruba,
        ),
      ),
      SizedBox(
          width: leftScrollExtent,
          child: pageNumber == 499
              ? null
              : UnconstrainedBox(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                      duration: _colorDuration,
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: colorChange ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      height: 50,
                      child: Center(
                          child: Text(
                        "${pageNumber + 2}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
                )),
    ];
    return Semantics(
      label: "Hymn Number ${widget.id}",
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.fill,
            child: Text(
              checkAppBarTitle(context, currentHymn.id),
              softWrap: true,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          elevation: 0,
          actions: [
            ChangeNotifierProvider.value(
              value: currentHymn,
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
        body: IgnorePointer(
          ignoring: ignoreTouch,
          child: ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.hardEdge,
            itemCount: list.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => list[index],
          ),
        ),
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
