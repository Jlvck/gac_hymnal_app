import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  String logo_1 = 'images/church_logo1.png';
  String logo_2 = 'images/church_logo2.png';

  String name = 'images/church_logo2.png';

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    double maxHeight = mediaQuery.size.height - mediaQuery.padding.top;
    double maxWidth = mediaQuery.size.width;
    return Scaffold(
        // backgroundColor: Colors.purple,
        body: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
      child: Center(
          child: Image.asset(
        name,
        fit: BoxFit.contain,
        alignment: Alignment.bottomCenter,
      )),
    ));
  }
}
