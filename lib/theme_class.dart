import "package:flutter/material.dart";

class ThemeClass {
  static final MaterialColor mycolor = MaterialColor(
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
      cardTheme: CardTheme(
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
        //color used for drawer background &
        //hymnview background scaffold(black in dark)
        background: Colors.white,
        // color for text..change to white in dark
        onBackground: Colors.black,
        error: const Color.fromARGB(255, 255, 0, 0),
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        //change to Color.rgbo(32,32,32,1) for dark theme
        primaryContainer: Colors.white,
      ));
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
      cardTheme: CardTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      useMaterial3: true,
      //change to black for dark theme
      scaffoldBackgroundColor: Colors.black,
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
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        //change color to white for darktheme
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        //color used for drawer background &
        //hymnview background scaffold(black in dark)
        background: Colors.black,
        // color for text..change to white in dark
        onBackground: Colors.white,
        error: Color.fromARGB(255, 255, 0, 0),
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        //change to Color.rgbo(32,32,32,1) for dark theme
        primaryContainer: Color.fromRGBO(32, 32, 32, 1),
      ));
}
