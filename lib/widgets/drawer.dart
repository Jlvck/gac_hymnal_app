// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import '../screens/hymn_book_screen.dart';
import '../screens/favorites_screen.dart';

class MainDrawer extends StatelessWidget {
  ListTile drawerListTile(String tileName, IconData tileIcon, String routeName,
      BuildContext context) {
    return ListTile(
      iconColor: Colors.white,
      hoverColor: Colors.black54,
      splashColor: Colors.black54,
      horizontalTitleGap: 5,
      contentPadding: EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
      visualDensity: VisualDensity(horizontal: 0, vertical: 0),
      leading: Icon(
        tileIcon,
        size: 30,
      ),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(routeName);
      },
      title: Text(
        tileName,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColorLight,
      child: ListView(padding: EdgeInsets.all(0), children: [
        DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
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
        drawerListTile(
            'HymnBook', Icons.music_note, HymnBookScreen.routeName, context),
        drawerListTile('Favorites', Icons.favorite_border,
            FavoritesScreen.routeName, context),
      ]),
    );
  }
}
