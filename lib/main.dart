import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import './theme_class.dart';

import 'providers/hymn_book_provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';

import 'screens/hymn_book_screen.dart';
import 'screens/favorites_screen.dart';

void main() async {
  await Future.sync(() => WidgetsFlutterBinding.ensureInitialized());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<HymnBookProvider>(
      create: (ctx) => HymnBookProvider(),
    ),
    ChangeNotifierProvider<NavigationProvider>(
        create: (ctx) => NavigationProvider()),
    ChangeNotifierProvider(create: (ctx) => LanguageProvider()),
    ChangeNotifierProvider<ThemeProvider>(
      create: (ctx) => ThemeProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    var brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    Provider.of<ThemeProvider>(context, listen: false).setTheme(brightness);
    super.didChangePlatformBrightness();
  }

  final MaterialColor mycolor = MaterialColor(
    const Color.fromRGBO(0, 0, 102, 1).value,
    const <int, Color>{
      50: Color.fromRGBO(49, 49, 181, 1),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      title: 'GAC Hymnal(Adigbe Branch)',
      themeMode: Provider.of<ThemeProvider>(context, listen: true).themeMode,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case ("/"):
            return PageTransition(
                child: const HymnBookScreen(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 300));
          case (HymnBookScreen.routeName):
            return PageTransition(
                child: const HymnBookScreen(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 300));
          case (FavoritesScreen.routeName):
            return PageTransition(
                child: const FavoritesScreen(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 300));
          default:
            return PageTransition(
                child: const HymnBookScreen(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 300));
        }

        // HymnBookScreen.routeName: (ctx) => const HymnBookScreen(),
        // FavoritesScreen.routeName: (ctx) => const FavoritesScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String logo_1 = 'assets/images/church_logo1.png';
  String logo_2 = 'assets/images/church_logo2.png';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: AnimatedSplashScreen.withScreenFunction(
        splash: Image.asset(
          logo_1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        screenFunction: () async {
          await Future.sync(() {
            final Brightness brightness =
                WidgetsBinding.instance.platformDispatcher.platformBrightness;
            Provider.of<ThemeProvider>(context, listen: false)
                .setTheme(brightness);
            Provider.of<HymnBookProvider>(context, listen: false)
                .setFavHymnList();
          });

          return const HymnBookScreen();
        },
        animationDuration: const Duration(milliseconds: 200),
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
