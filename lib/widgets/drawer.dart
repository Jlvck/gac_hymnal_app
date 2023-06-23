// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import '../screens/hymn_book_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColorDark,
      child: ListView(padding: EdgeInsets.all(0), children: [
        DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
              image: AssetImage('images/church_image_drawer.png'),
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
          ),
        ),
        ListTile(
          iconColor: Colors.white,
          hoverColor: Colors.black54,
          splashColor: Colors.black54,
          horizontalTitleGap: 5,
          contentPadding:
              EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
          visualDensity: VisualDensity(horizontal: 0, vertical: 0),
          leading: Icon(
            Icons.music_note,
            size: 30,
          ),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(HymnBookScreen.routeName);
          },
          title: Text(
            'Hymn Book',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        ListTile(
          iconColor: Colors.white,
          hoverColor: Colors.black54,
          splashColor: Colors.black54,
          contentPadding:
              EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
          horizontalTitleGap: 5,
          visualDensity: VisualDensity(horizontal: 0, vertical: 0),
          leading: Icon(
            Icons.favorite_border,
            size: 30,
          ),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(HymnBookScreen.routeName);
          },
          title: Text(
            'Favorites',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]),
    );
  }
}
