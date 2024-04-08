import 'package:church/model/language_item.dart';
import 'package:church/features/hymn/presentation/controllers/language_provider.dart';
import 'package:church/widgets/toggle_theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../controllers/hymn_book_provider.dart';

import 'hymn_view_screen.dart';
import '../../../../widgets/main_text_field.dart';
import '../../../../widgets/displayed_hymn_list.dart';
import '../../../../widgets/drawer.dart';
import '../../../../widgets/language_popup_menu.dart';

import '../../../../model/hymn.dart';

class HymnBookScreen extends StatefulWidget {
  static const routeName = '/hymn_category';

  const HymnBookScreen({super.key});

  @override
  State<HymnBookScreen> createState() => _HymnBookScreenState();
}

class _HymnBookScreenState extends State<HymnBookScreen> {
  static const screenName = 'Hymnbook';
  final _enteredHymnNumber = TextEditingController();
  final _enteredHymnTitle = TextEditingController();

  final ScrollController _scroll = ScrollController();

  List<Hymn> _staticHymns = [];
  final ValueNotifier<List<Hymn>> _foundHymns = ValueNotifier(<Hymn>[]);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final preHymn = Provider.of<HymnBookProvider>(context, listen: true);

    _staticHymns = preHymn.hymnList;

    _foundHymns.value = _foundHymns.value.isEmpty &&
            _enteredHymnNumber.value.text.isEmpty &&
            _enteredHymnTitle.value.text.isEmpty
        ? _staticHymns
        : _foundHymns.value;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _enteredHymnNumber.dispose();
    _enteredHymnTitle.dispose();
    _scroll.dispose();
    _foundHymns.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    double maxHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: MainDrawer(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text(
            screenName,
            overflow: TextOverflow.visible,
          ),
          actions: [
            const ToggleThemeSwitch(),
            LanguagePopUpMenu(
              clearControllers: clearControllers,
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            height: maxHeight,
            width: maxWidth,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    color: Theme.of(context).primaryColor,
                    //TextField
                    child: MainTextField(
                      runFilter: _runFilter,
                      enteredHymnNumber: _enteredHymnNumber,
                      enteredHymnTitle: _enteredHymnTitle,
                      foundHymns: _foundHymns.value,
                      onTapTitle: _onTapTitle,
                      onChangedTitle: _onChangedTitle,
                      onChangedNumber: _onChangedNumber,
                      onSubmittedNumber: _onSubmittedNumber,
                      onTapNumber: _onTapNumber,
                      reset: _reset,
                    )),
                //List of Hymns displayed controlled by a value listener
                ValueListenableBuilder(
                    valueListenable: _foundHymns,
                    builder: (BuildContext context, value, child) {
                      return DisplayedHymnList(
                          foundHymns: value, scroll: _scroll);
                    }),
              ],
            ),
          ),
        ));
  }

  void _toScrollStart() {
    _scroll.jumpTo(0);
  }

  void clearControllers() {
    _enteredHymnTitle.clear();
    _enteredHymnNumber.clear();
    _reset();
  }

  void _onTapTitle() {
    if (_enteredHymnTitle.value.text.isEmpty &
        _enteredHymnNumber.value.text.isEmpty) {
      if (_scroll.hasClients) {
        _toScrollStart();
      }
      return;
    } else {
      if (_enteredHymnTitle.value.text.isEmpty) {
        _enteredHymnNumber.clear();
        _runFilter(_enteredHymnNumber.value.text.toLowerCase());
      } else {
        _enteredHymnNumber.clear();
      }
    }
  }

  void _onChangedTitle(String value) {
    if (value == '') {
      _foundHymns.value = _staticHymns;

      if (_scroll.hasClients) {
        _toScrollStart();
      }
    } else {
      _runFilter(value.toLowerCase());
      if (_scroll.hasClients) {
        _toScrollStart();
      }
    }
  }

  void _onTapNumber() {
    if (_enteredHymnTitle.value.text.isEmpty &
        _enteredHymnNumber.value.text.isEmpty) {
      if (_scroll.hasClients) {
        _toScrollStart();
      }
      return;
    } else {
      if (_enteredHymnNumber.value.text.isEmpty) {
        _enteredHymnTitle.clear();
        _runFilter(_enteredHymnTitle.value.text.toLowerCase());
      } else {
        _enteredHymnTitle.clear();
      }
    }
  }

  void _onChangedNumber(String value) {
    if (value == '') {
      _foundHymns.value = _staticHymns;

      if (_scroll.hasClients) {
        _toScrollStart();
      }
    } else {
      _runFilter(value.toLowerCase());
      if (_scroll.hasClients) {
        _toScrollStart();
      }
    }
  }

  void _reset() {
    _foundHymns.value = _staticHymns;
  }

  void _onSubmittedNumber(String submit, List<Hymn> hymnData) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (hymnData.any((hymn) => hymn.id == submit)) {
      Navigator.of(context)
          .push(PageTransition(
            type: PageTransitionType.fade,
            child: HymnViewScreen(
              id: submit,
            ),
            duration: const Duration(milliseconds: 300),
          ))
          .then(
              (value) => Provider.of<HymnBookProvider>(context, listen: false));
      _enteredHymnNumber.clear();
      _foundHymns.value = _staticHymns;
      FocusManager.instance.primaryFocus?.unfocus();
    } else {
      return;
    }
  }

  void _runFilter(String enteredUserHymn) {
    List<Hymn> results = [];

    if (enteredUserHymn.isEmpty ||
        enteredUserHymn == "/" ||
        enteredUserHymn == "") {
      results = _staticHymns;
    } else {
      if (Provider.of<LanguageProvider>(context, listen: false).currentItem ==
          LanguageItem.yoruba) {
        results = _staticHymns
            .where((hymnbook) =>
                hymnbook.versesYoruba[0][0]
                    .toLowerCase()
                    .contains(enteredUserHymn) ||
                hymnbook.id.toLowerCase().contains(enteredUserHymn) ||
                hymnbook.versesYoruba[0][0].contains(enteredUserHymn))
            .toList();

        _foundHymns.value = results;
      } else {
        results = _staticHymns
            .where((hymnbook) =>
                hymnbook.versesEnglish[0][0]
                    .toLowerCase()
                    .contains(enteredUserHymn) ||
                hymnbook.id.toLowerCase().contains(enteredUserHymn) ||
                hymnbook.versesEnglish[0][0].contains(enteredUserHymn))
            .toList();

        _foundHymns.value = results;
      }
    }

    _foundHymns.value = results;
  }
}
