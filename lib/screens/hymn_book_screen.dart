import 'package:church/model/language_item.dart';
import 'package:church/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/hymn_book_provider.dart';

import 'hymn_view_screen.dart';

import '../widgets/drawer.dart';
import '../widgets/hymn_list_view.dart';
import '../widgets/language_popupMenu.dart';

import '../model/hymn.dart';

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
  List<Hymn> _foundHymns = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final preHymn = Provider.of<HymnBookProvider>(context, listen: true);

    _staticHymns = preHymn.hymnList;

    _foundHymns = _foundHymns.isEmpty &&
            _enteredHymnNumber.value.text.isEmpty &&
            _enteredHymnTitle.value.text.isEmpty
        ? _staticHymns
        : _foundHymns;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _enteredHymnNumber.dispose();
    _enteredHymnTitle.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    double maxHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;
    print('build screen');
    return Scaffold(
        resizeToAvoidBottomInset: true,
        drawer: MainDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            screenName,
            overflow: TextOverflow.visible,
          ),
          actions: const [LanguagePopUpMenu()],
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            height: maxHeight,
            width: maxWidth,
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                mainTextField(mediaQuery, context),
                const Padding(padding: EdgeInsets.all(8)),
                displayedHymnList(context)
              ],
            ),
          ),
        ));
  }

  Flexible displayedHymnList(BuildContext context) {
    return Flexible(
      child: _foundHymns.isNotEmpty
          ? Scrollbar(
              thumbVisibility: false,
              trackVisibility: false,
              interactive: true,
              controller: _scroll,
              radius: const Radius.circular(4),
              thickness: 10,
              child: HymnListView(
                hymnList: _foundHymns,
                scroll: _scroll,
              ))
          : const Text(
              'No results found',
              style: TextStyle(fontSize: 24),
            ),
    );
  }

  Row mainTextField(MediaQueryData mediaQuery, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: mediaQuery.size.width * 3 / 4),
          child: Container(
            margin: const EdgeInsets.only(
              left: 40,
            ),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Theme.of(context).primaryColorLight,
            ),
            child: SizedBox(
              height: 40,
              child: TextField(
                cursorColor: Colors.white,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                strutStyle: const StrutStyle(
                  forceStrutHeight: true,
                ),
                style: const TextStyle(fontSize: 23, color: Colors.white),
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                onTap: () => onTapTitle(),
                controller: _enteredHymnTitle,
                onChanged: (value) => onChangedTitle(value),
                keyboardType: TextInputType.text,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.all(5),
                  hintStyle: const TextStyle(color: Colors.white),
                  hintText: 'Search....',
                  hintMaxLines: 1,
                  hintTextDirection: TextDirection.ltr,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  suffix: IconButton(
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    color: Theme.of(context).primaryColor,
                    icon: const Icon(
                      Icons.cancel,
                      size: 22,
                      color: Colors.white,
                    ),
                    tooltip: "clear input",
                    onPressed: () {
                      setState(() {
                        _enteredHymnTitle.clear();
                        _runFilter(_enteredHymnTitle.text.toLowerCase());
                      });
                    },
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: mediaQuery.size.width * 1 / 4),
          child: Container(
            margin: const EdgeInsets.only(right: 40),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: SizedBox(
              height: 40,
              child: TextField(
                cursorColor: Colors.white,
                style: const TextStyle(fontSize: 20, color: Colors.white),
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                onTap: () => onTapNumber(),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: false,
                  signed: false,
                ),
                onChanged: (value) => onChangedNumber(value),
                onSubmitted: (submit) => onSubmittedNumber(submit, _foundHymns),
                controller: _enteredHymnNumber,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    hintText: '#',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 22),
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _toScrollStart() {
    _scroll.jumpTo(0);
  }

  void onTapTitle() {
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

  void onChangedTitle(String value) {
    if (value == '') {
      setState(() {
        _foundHymns = _staticHymns;
      });
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

  void onTapNumber() {
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

  void onChangedNumber(String value) {
    if (value == '') {
      setState(() {
        _foundHymns = _staticHymns;
      });
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

  void onSubmittedNumber(String submit, List<Hymn> hymnData) {
    if (hymnData.any((hymn) => hymn.id == submit)) {
      Navigator.push(
              context,
              MaterialPageRoute(
                // ignore: prefer_const_constructors
                builder: (t) => HymnViewScreen(
                  id: submit,
                ),
              ))
          .then((value) =>
              Provider.of<HymnBookProvider>(context, listen: false).notify());
      _enteredHymnNumber.clear();
      _foundHymns = _staticHymns;
      FocusManager.instance.primaryFocus?.unfocus();
    } else {
      return;
    }
  }

  void _runFilter(String enteredUserHymn) {
    List<Hymn> results = [];

    if (enteredUserHymn.isEmpty) {
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
        setState(() {
          _foundHymns = results;
        });
      } else {
        results = _staticHymns
            .where((hymnbook) =>
                hymnbook.versesEnglish[0][0]
                    .toLowerCase()
                    .contains(enteredUserHymn) ||
                hymnbook.id.toLowerCase().contains(enteredUserHymn) ||
                hymnbook.versesEnglish[0][0].contains(enteredUserHymn))
            .toList();
        setState(() {
          _foundHymns = results;
        });
      }
    }

    _foundHymns = results;
  }
}
