import 'package:flutter/material.dart';

class HymnEnglishScreen extends StatelessWidget {
  const HymnEnglishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.exit_to_app),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        title: Text("Hymn 001"),
      ),
      body: Center(child: Text("This is English Hymn")),
    );
  }
}
