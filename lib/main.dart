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
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      title: 'GAC Hymnal',
      themeMode: Provider.of<ThemeProvider>(context, listen: true).themeMode,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case ("/"):
            return PageTransition(
                child: const HymnBookScreen(),
                type: PageTransitionType.rightToLeftWithFade,
                duration: const Duration(milliseconds: 300));
          case (HymnBookScreen.routeName):
            return PageTransition(
                child: const HymnBookScreen(),
                type: PageTransitionType.rightToLeftWithFade,
                duration: const Duration(milliseconds: 300));
          case (FavoritesScreen.routeName):
            return PageTransition(
                child: const FavoritesScreen(),
                type: PageTransitionType.rightToLeftWithFade,
                duration: const Duration(milliseconds: 300));
          default:
            return PageTransition(
                child: const HymnBookScreen(),
                type: PageTransitionType.rightToLeftWithFade,
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
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: AnimatedSplashScreen.withScreenFunction(
        splash: Image.asset(
          "assets/images/icon_image.png",
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
        duration: 2500,
        animationDuration: const Duration(milliseconds: 500),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
