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
  final enteredHymnNumber = TextEditingController();

  @override
  @override
  void dispose() {
    enteredHymnNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hymnData = Provider.of<HymnBook>(context);
    return Scaffold(
        appBar: AppBar(title: Text('HYMNBOOK')),
        body: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: Row(
            children: [
              Icon(Icons.search),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  onSubmitted: (_) {
                    final Hymn selectedHymn =
                        hymnData.getHymn(enteredHymnNumber.value.text);
                    Navigator.of(context)
                        .pushNamed(HymnView.routeName, arguments: selectedHymn);
                    enteredHymnNumber.clear();
                  },
                  controller: enteredHymnNumber,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    labelText: 'Search for hymn by number',
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
