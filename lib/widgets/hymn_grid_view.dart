import 'package:flutter/material.dart';
import 'package:gac_hymnal_app/widgets/animated_icon_button_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../model/hymn.dart';
import '../model/language_item.dart';

import '../providers/language_provider.dart';
import '../screens/hymn_view_screen.dart';

class HymnGridView extends StatefulWidget {
  final List<Hymn> hymnList;

  final ScrollController scroll;

  const HymnGridView({
    super.key,
    required this.hymnList,
    required this.scroll,
  });

  @override
  State<HymnGridView> createState() => _HymnGridViewState();
}

class _HymnGridViewState extends State<HymnGridView>
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
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 0),
      child: GridView(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        controller: widget.scroll,
        physics: const BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        semanticChildCount: widget.hymnList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 110,
        ),
        children:
            List.generate(widget.hymnList.length, growable: true, (index) {
          return Semantics(
            label: "Hymn number${index + 1}",
            child: Container(
              width: (mediaQueryData.size.width / 5) - 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: Theme.of(context).colorScheme.surface),
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              height: 110,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, bottom: 0, top: 2),
                          child: Text(
                            checkTitle(context, index),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.onSurface),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: (mediaQueryData.size.width / 5),
                      padding: EdgeInsets.only(left: 10, right: 0),
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
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
                          Flexible(child: SizedBox.expand()),
                          Align(
                              alignment: Alignment.centerRight,
                              child: AnimatedIconButtonWidget(
                                  hymn: widget.hymnList[index],
                                  animation: _animation)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
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
