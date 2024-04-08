import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import './theme_class.dart';

import 'features/hymn/presentation/controllers/hymn_book_provider.dart';
import 'features/hymn/presentation/controllers/navigation_provider.dart';
import 'features/hymn/presentation/controllers/language_provider.dart';
import 'features/hymn/presentation/controllers/theme_provider.dart';

import 'features/hymn/presentation/screens/hymn_book_screen.dart';
import 'features/hymn/presentation/screens/favorites_screen.dart';
import 'features/hymn/presentation/screens/splash_screen.dart';

class RunApp extends StatelessWidget {
  const RunApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //List of Provider Classes
    return MultiProvider(providers: [
      ChangeNotifierProvider<HymnBookProvider>(
        create: (ctx) => HymnBookProvider(),
      ),
      ChangeNotifierProvider<NavigationProvider>(
          create: (ctx) => NavigationProvider()),
      ChangeNotifierProvider(create: (ctx) => LanguageProvider()),
      ChangeNotifierProvider<ThemeProvider>(
        create: (ctx) => ThemeProvider(),
      ),
    ], child: const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    //to observer platfrom brightness changes
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
    //function called when host platfrom changes brigtness
    var brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    //function to change brightness
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
    return const SplashScreen();
  }
}
