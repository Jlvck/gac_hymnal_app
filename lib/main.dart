// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import './providers/hymn_book.dart';
import 'screens/hymn_book_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/hymn_view_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MaterialColor mycolor = MaterialColor(
    Color.fromRGBO(0, 0, 102, 1).value,
    <int, Color>{
      50: Color.fromRGBO(0, 0, 105, 1),
      100: Color.fromRGBO(0, 0, 108, 1),
      200: Color.fromRGBO(1, 1, 113, 1),
      300: Color.fromRGBO(3, 3, 115, 1),
      400: Color.fromRGBO(0, 0, 102, 1),
      500: Color.fromRGBO(0, 0, 102, 1),
      600: Color.fromRGBO(0, 0, 102, 1),
      700: Color.fromRGBO(0, 0, 102, 1),
      800: Color.fromRGBO(0, 0, 102, 1),
      900: Color.fromRGBO(0, 0, 102, 1),
    },
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => HymnBook(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
        title: 'GAC Hymnal(Adigbe Branch)',
        theme: ThemeData(
          primarySwatch: mycolor,
        ),
        routes: {
          HymnBookScreen.routeName: (ctx) => HymnBookScreen(),
          HymnViewScreen.routeName: (ctx) => HymnViewScreen(),
          FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String logo_1 = 'images/church_logo1.png';
  String logo_2 = 'images/church_logo2.png';

  String name = 'images/church_logo2.png';

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: Image.asset(
        name,
      ),
      backgroundColor: Colors.white,
      screenFunction: () async {
        Provider.of<HymnBook>(context, listen: false).setListtoSF();
        Provider.of<HymnBook>(context, listen: false).setFavHymnList();
        return HymnBookScreen();
      },
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}
