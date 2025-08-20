import "package:flutter/material.dart";

class ThemeClass {
  static final MaterialColor mycolor = MaterialColor(
    400,
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

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
      listTileTheme: const ListTileThemeData(tileColor: Colors.white),
      primaryTextTheme: const TextTheme(
        //TextField text style(Light)
        //Change text Color to white for dark theme
        titleMedium: TextStyle(
            fontSize: 23, color: Colors.black, fontWeight: FontWeight.normal),
      ),
      cardTheme: CardThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      useMaterial3: true,
      //change to black for dark theme
      scaffoldBackgroundColor: const Color.fromARGB(255, 235, 228, 242),
      dividerTheme: const DividerThemeData(color: Colors.transparent),
      //App Bar Theme(light)
      appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: mycolor.shade400,
          centerTitle: true,
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
      primarySwatch: mycolor,
      secondaryHeaderColor: const Color.fromARGB(255, 255, 0, 0),
      primaryColor: mycolor.shade400,
      colorScheme: ColorScheme(
          brightness: Brightness.light,

          //change color to white for darktheme
          primary: mycolor.shade400,
          onPrimary: Colors.white,
          secondary: Colors.black,
          onSecondary: Colors.white,
          error: const Color.fromARGB(255, 255, 0, 0),
          onError: Colors.white,

          //background color for text(black in dark theme)
          surface: Colors.white,

          //Text color (white in dark theme)
          onSurface: Colors.black,

          //change to Color.rgbo(32,32,32,1) for dark theme
          primaryContainer: Colors.white,

          //Color used for the side number boxes
          tertiary: const Color.fromARGB(255, 116, 116, 116)));
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
      listTileTheme: const ListTileThemeData(tileColor: Colors.black),
      primaryTextTheme: const TextTheme(
        //TextField text style(Light)
        //Change text Color to white for dark theme
        titleMedium: TextStyle(
            fontSize: 23, color: Colors.white, fontWeight: FontWeight.normal),
      ),
      cardTheme: CardThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      useMaterial3: true,

      //change to black for dark theme
      scaffoldBackgroundColor: const Color.fromRGBO(32, 32, 32, 1),
      dividerTheme: const DividerThemeData(color: Colors.transparent),

      //App Bar Theme(black)
      appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: mycolor.shade400,
          centerTitle: true,
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
      primarySwatch: mycolor,
      secondaryHeaderColor: const Color.fromARGB(255, 255, 0, 0),
      primaryColor: mycolor.shade400,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,

        //change color to black for lighttheme
        primary: Colors.white,

        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        error: Color.fromARGB(255, 255, 0, 0),
        onError: Colors.white,

        //background color for text(white in light theme)
        surface: Colors.black,

        //Text color (black in light theme)
        onSurface: Colors.white,

        //white for light theme
        primaryContainer: Color.fromRGBO(32, 32, 32, 1),

        //Color used for the side number boxes
        tertiary: Color.fromARGB(255, 85, 85, 85),
      ));
}
