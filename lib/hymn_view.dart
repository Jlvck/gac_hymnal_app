// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class HymnView extends StatelessWidget {
  static const routeName = '/hymn_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HYMN VIEW')),
      body: Center(
        child: Text('Hymn!'),
      ),
    );
  }
}
