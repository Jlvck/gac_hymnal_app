import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'hymn_view_screen.dart';
import '../model/hymn.dart';
import '../providers/hymn_book_provider.dart';
import '../widgets/drawer.dart';
import '../widgets/hymn_list_view.dart';

class HymnBookScreen extends StatefulWidget {
  static const routeName = '/hymn_category';

  const HymnBookScreen({super.key});

  @override
  State<HymnBookScreen> createState() => _HymnBookScreenState();
}

class _HymnBookScreenState extends State<HymnBookScreen> {
  final _enteredHymnNumber = TextEditingController();
  final _enteredHymnTitle = TextEditingController();

  final ScrollController _scroll = ScrollController();

  List<Hymn> _staticHymns = [];
  List<Hymn> _foundHymns = [];

  void onTapTitle() {
    if (_enteredHymnTitle.value.text.isEmpty &
        _enteredHymnNumber.value.text.isEmpty) {
      return;
    } else {
      if (_enteredHymnTitle.value.text.isEmpty) {
        setState(() {
          _enteredHymnNumber.clear();
          _runFilter(_enteredHymnNumber.value.text);
        });
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
        _scroll.jumpTo(0);
      }
    } else {
      _runFilter(value);
      if (_scroll.hasClients) {
        _scroll.jumpTo(0);
      }
    }
  }

  void onTapNumber() {
    if (_enteredHymnTitle.value.text.isEmpty &
        _enteredHymnNumber.value.text.isEmpty) {
      return;
    } else {
      if (_enteredHymnNumber.value.text.isEmpty) {
        setState(() {
          _enteredHymnTitle.clear();
          _runFilter(_enteredHymnTitle.value.text);
        });
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
        _scroll.jumpTo(0);
      }
    } else {
      _runFilter(value);
      if (_scroll.hasClients) {
        _scroll.jumpTo(0);
      }
    }
  }

  void onSubmittedNumber(String submit, HymnBookProvider hymnData) {
    if (hymnData.hymnList.any((hymn) => hymn.id == submit)) {
      final Hymn selectedHymn = hymnData.getHymn(submit);
      _enteredHymnNumber.clear();
      _foundHymns = _staticHymns;
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.of(context)
          .pushNamed(HymnViewScreen.routeName, arguments: selectedHymn);
    } else {
      return;
    }
  }

  void _runFilter(String enteredUserHymn) {
    List<Hymn> results = [];

    if (enteredUserHymn.isEmpty) {
      results = _staticHymns;
    } else {
      results = _staticHymns
          .where((hymnbook) =>
              hymnbook.verses[0][0].toLowerCase().contains(enteredUserHymn) ||
              hymnbook.id.toLowerCase().contains(enteredUserHymn) ||
              hymnbook.verses[0][0].contains(enteredUserHymn))
          .toList();
      setState(() {
        _foundHymns = results;
      });
    }

    _foundHymns = results;
  }

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

  Flexible displayedHymnList(HymnBookProvider hymnData, BuildContext context) {
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
                wholeProv: false,
              ))
          : const Text(
              'No results found',
              style: TextStyle(fontSize: 24),
            ),
    );
  }

  Row mainTextField(MediaQueryData mediaQuery, BuildContext context,
      HymnBookProvider hymnData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: mediaQuery.size.width * 3 / 4),
          child: Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: SizedBox(
              height: 40,
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                strutStyle: const StrutStyle(
                  forceStrutHeight: true,
                ),
                style: const TextStyle(fontSize: 23),
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                onTap: () => onTapTitle(),
                controller: _enteredHymnTitle,
                onChanged: (value) => onChangedTitle(value),
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  hintText: 'Search....',
                  hintMaxLines: 1,
                  hintTextDirection: TextDirection.ltr,
                  prefixIcon: const Icon(Icons.search),
                  suffix: IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    color: Theme.of(context).primaryColor,
                    icon: const Icon(
                      Icons.cancel,
                      size: 25,
                    ),
                    tooltip: "clear input",
                    onPressed: () {
                      setState(() {
                        _enteredHymnTitle.clear();
                        _runFilter(_enteredHymnTitle.text);
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
            margin: const EdgeInsets.only(right: 20, top: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: SizedBox(
              height: 40,
              child: TextField(
                style: const TextStyle(fontSize: 20),
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                onTap: () => onTapNumber(),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: false,
                  signed: false,
                ),
                onChanged: (value) => onChangedNumber(value),
                onSubmitted: (submit) => onSubmittedNumber(submit, hymnData),
                controller: _enteredHymnNumber,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    hintText: '#',
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    double maxHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;
    final hymnData = Provider.of<HymnBookProvider>(context, listen: true);
    final int totalHymnNumber = hymnData.hymnList.length;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        drawer: MainDrawer(),
        appBar: AppBar(
          title: const Text(
            'HYMNBOOK',
            overflow: TextOverflow.visible,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  totalHymnNumber.toString(),
                  style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            height: maxHeight,
            width: maxWidth,
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                mainTextField(mediaQuery, context, hymnData),
                const Padding(padding: EdgeInsets.all(8)),
                displayedHymnList(hymnData, context)
              ],
            ),
          ),
        ));
  }
}
