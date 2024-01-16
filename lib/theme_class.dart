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
      titleMedium: TextStyle(
          fontSize: 23, color: Colors.black, fontWeight: FontWeight.normal),
    ),
    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    useMaterial3: true,
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
  );
}
