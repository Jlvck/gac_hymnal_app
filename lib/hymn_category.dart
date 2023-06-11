// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './hymn_view.dart';
import './providers/hymn.dart';
import './providers/hymn_book.dart';

class HymnCategory extends StatefulWidget {
  static const routeName = '/hymn_category';

  @override
  State<HymnCategory> createState() => _HymnCategoryState();
}

class _HymnCategoryState extends State<HymnCategory> {
  final _enteredHymnNumber = TextEditingController();
  final _enteredHymnTitle = TextEditingController();
  final FocusNode myfocusNode = FocusNode();

  List<Hymn> _staticHymns = [];
  List<Hymn> _foundHymns = [];

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
    final preHymn = Provider.of<HymnBook>(context, listen: false);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('......building state');
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final hymnData = Provider.of<HymnBook>(context, listen: false);
    return Scaffold(
        appBar: AppBar(title: const Text('HYMNBOOK')),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: mediaQuery.size.width * 3 / 4),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onTapOutside: (event) => null,
                              onTap: () {
                                if (_enteredHymnTitle.value.text.isEmpty) {
                                  setState(() {
                                    _enteredHymnNumber.clear();
                                  });
                                  _runFilter(_enteredHymnNumber.value.text);
                                } else {
                                  _enteredHymnNumber.clear();
                                }
                              },
                              controller: _enteredHymnTitle,
                              onChanged: (value) {
                                if (value == '') {
                                  setState(() {
                                    _foundHymns = _staticHymns;
                                  });
                                } else {
                                  _runFilter(value);
                                }
                              },
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Search for hymn by title',
                                  prefixIcon: Icon(Icons.search),
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: mediaQuery.size.width * 1 / 4),
                    child: Container(
                      margin: EdgeInsets.only(right: 20, top: 10),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onTap: () {
                                if (_enteredHymnNumber.value.text.isEmpty) {
                                  setState(() {
                                    _enteredHymnTitle.clear();
                                  });
                                  _runFilter(_enteredHymnTitle.value.text);
                                } else {
                                  _enteredHymnTitle.clear();
                                }
                              },
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: false,
                                signed: false,
                              ),
                              onChanged: (value) {
                                if (value == '') {
                                  setState(() {
                                    _foundHymns = _staticHymns;
                                  });
                                } else {
                                  _runFilter(value);
                                }
                              },
                              onSubmitted: (_) {
                                if (_enteredHymnNumber.value.text.isEmpty) {
                                  return;
                                }
                                final Hymn selectedHymn = hymnData
                                    .getHymn(_enteredHymnNumber.value.text);

                                _enteredHymnNumber.clear();
                                _runFilter(_enteredHymnNumber.text);
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.of(context).pushNamed(
                                    HymnView.routeName,
                                    arguments: selectedHymn);
                              },
                              controller: _enteredHymnNumber,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: '#',
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(8)),
              Flexible(
                child: _foundHymns.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (ctx, index) => GestureDetector(
                              onTap: () {
                                final Hymn selectedHymn =
                                    hymnData.getHymn(_foundHymns[index].id);
                                Navigator.of(context).pushNamed(
                                    HymnView.routeName,
                                    arguments: selectedHymn);
                                // setState(() {
                                //   _enteredHymnNumber.clear();
                                //   _enteredHymnTitle.clear();
                                // });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text(_foundHymns[index].id),
                                    ),
                                    title: Text(
                                        "${_foundHymns[index].verses[0][0]} "),
                                  ),
                                ),
                              ),
                            ),
                        itemCount: _foundHymns.length)
                    : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
              )
            ],
          ),
        ));
  }
}
