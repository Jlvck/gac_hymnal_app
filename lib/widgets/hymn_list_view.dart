import 'package:flutter/material.dart';
import 'package:gac_hymnal_app/widgets/animated_icon_button_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../model/hymn.dart';
import '../model/language_item.dart';

import '../providers/language_provider.dart';
import '../screens/hymn_view_screen.dart';

class HymnListView extends StatefulWidget {
  final List<Hymn> hymnList;
  final ScrollController scroll;

  const HymnListView({
    super.key,
    required this.hymnList,
    required this.scroll,
  });

  @override
  State<HymnListView> createState() => _HymnListViewState();
}

class _HymnListViewState extends State<HymnListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  static const Duration _animationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: _animationDuration,
        reverseDuration: _animationDuration);

    _animation = Tween<double>(begin: 24.0, end: 30).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));

    Future.delayed(
      Duration(seconds: 2),
      () {
        _controller.forward().then(
          (value) async {
            await Future.delayed(Duration(milliseconds: 200));
            _controller.reverse();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 0),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        controller: widget.scroll,
        physics: const BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        semanticChildCount: widget.hymnList.length,
        itemExtent: 50,
        children:
            List.generate(widget.hymnList.length, growable: true, (index) {
          return Semantics(
            label: "Hymn number ${index + 1}",
            child: Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  height: double.maxFinite,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              childCurrent: widget,
                              child: HymnViewScreen(
                                id: widget.hymnList[index].id,
                              ),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300)));
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      tileColor: Theme.of(context).colorScheme.surface,
                      selectedColor: Theme.of(context).colorScheme.surface,
                      isThreeLine: false,
                      dense: true,
                      horizontalTitleGap: 10,
                      minVerticalPadding: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      minLeadingWidth: 50,
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: Container(
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6)),
                          color: Theme.of(context).primaryColor,
                        ),
                        height: double.maxFinite,
                        padding: const EdgeInsets.all(2),
                        width: 50,
                        child: Center(
                          child: FittedBox(
                            child: Text(widget.hymnList[index].id,
                                softWrap: false,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      title: Text(
                        checkTitle(context, index),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSurface),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: AnimatedIconButtonWidget(
                        animation: _animation,
                        hymn: widget.hymnList[index],
                      ),
                    ),
                  ),
                )),
          );
        }),
      ),
    );
  }

  String checkTitle(BuildContext context, int index) {
    LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;
    if (currentLanguage == LanguageItem.yoruba) {
      return widget.hymnList[index].hymnTitleYoruba;
    } else {
      return widget.hymnList[index].hymnTitleEnglish;
    }
  }
}
