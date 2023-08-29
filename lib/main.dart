import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'providers/hymn_book_provider.dart';
import 'providers/navigation_provider.dart';
import 'screens/hymn_book_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/hymn_view_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MaterialColor mycolor = MaterialColor(
    const Color.fromRGBO(0, 0, 102, 1).value,
    const <int, Color>{
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

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HymnBookProvider>(
          create: (ctx) => HymnBookProvider(),
        ),
        ChangeNotifierProvider<NavigationProvider>(
            create: (ctx) => NavigationProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
        title: 'GAC Hymnal(Adigbe Branch)',
        theme: ThemeData(
                primarySwatch: mycolor,
                colorScheme: ColorScheme.fromSwatch(primarySwatch: mycolor))
            .copyWith(
                secondaryHeaderColor: const Color.fromARGB(255, 255, 0, 0)),
        routes: {
          HymnBookScreen.routeName: (ctx) => const HymnBookScreen(),
          HymnViewScreen.routeName: (ctx) => const HymnViewScreen(),
          FavoritesScreen.routeName: (ctx) => const FavoritesScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String logo_1 = 'images/church_logo1.png';
  String logo_2 = 'images/church_logo2.png';

  String name = 'images/church_logo2.png';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: AnimatedSplashScreen.withScreenFunction(
        splash: Image.asset(
          name,
        ),
        backgroundColor: Colors.white,
        screenFunction: () async {
          Provider.of<HymnBookProvider>(context, listen: false)
              .setFavHymnList();
          return const HymnBookScreen();
        },
        pageTransitionType: PageTransitionType.leftToRight,
      ),
    );
  }
}
