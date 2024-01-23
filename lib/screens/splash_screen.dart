import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../providers/hymn_book_provider.dart';
import '../providers/theme_provider.dart';

import 'hymn_book_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "SPLASH SCREEN FOR GAC HYMNAL",
      child: PopScope(
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
      ),
    );
  }
}
