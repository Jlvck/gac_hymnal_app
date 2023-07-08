// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'hymn_view_screen.dart';
import '../providers/hymn.dart';
import '../providers/hymn_book.dart';
import '../widgets/drawer.dart';
import '../widgets/hymn_list_view.dart';

class HymnBookScreen extends StatefulWidget {
  static const routeName = '/hymn_category';

  @override
  State<HymnBookScreen> createState() => _HymnBookScreenState();
}

class _HymnBookScreenState extends State<HymnBookScreen> {
  final _enteredHymnNumber = TextEditingController();
  final _enteredHymnTitle = TextEditingController();
  final FocusNode myfocusNode = FocusNode();

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

  void onSubmittedNumber(String submit, HymnBook hymnData) {
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
              hymnbook.id.toLowerCase().contains(enteredUserHymn))
          .toList();
      setState(() {
        _foundHymns = results;
      });
    }

    _foundHymns = results;
  }

  @override
  void initState() {
    print('........initstate');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final preHymn = Provider.of<HymnBook>(context, listen: true);

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
    myfocusNode.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Flexible displayedHymnList(HymnBook hymnData, BuildContext context) {
    return Flexible(
      child: _foundHymns.isNotEmpty
          ? Scrollbar(
              thumbVisibility: false,
              trackVisibility: false,
              interactive: true,
              controller: _scroll,
              radius: Radius.circular(4),
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

  Row mainTextField(
      MediaQueryData mediaQuery, BuildContext context, HymnBook hymnData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: mediaQuery.size.width * 3 / 4),
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: TextField(
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onTap: () => onTapTitle(),
              controller: _enteredHymnTitle,
              onChanged: (value) => onChangedTitle(value),
              keyboardType: TextInputType.text,
              autocorrect: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'Search for hymn by title',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: mediaQuery.size.width * 1 / 4),
          child: Container(
            margin: EdgeInsets.only(right: 20, top: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: TextField(
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onTap: () => onTapNumber(),
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
                signed: false,
              ),
              onChanged: (value) => onChangedNumber(value),
              onSubmitted: (submit) => onSubmittedNumber(submit, hymnData),
              controller: _enteredHymnNumber,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: '#',
                  border: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('......building state');
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final hymnData = Provider.of<HymnBook>(context, listen: true);
    final int totalHymnNumber = hymnData.hymnList.length;
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: const Text('HYMNBOOK'),
          actions: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  totalHymnNumber.toString(),
                  style: TextStyle(fontSize: 25, color: Colors.red),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            mainTextField(mediaQuery, context, hymnData),
            const Padding(padding: EdgeInsets.all(8)),
            displayedHymnList(hymnData, context)
          ],
        ));
  }
}
