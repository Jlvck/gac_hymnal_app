import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../providers/theme_provider.dart';

class ToggleThemeSwitch extends StatelessWidget {
  const ToggleThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: FittedBox(
        child: ToggleSwitch(
          minWidth: 30.0,
          minHeight: 30.0,
          initialLabelIndex: Provider.of<ThemeProvider>(context, listen: true)
                      .currentBrigtness ==
                  Brightness.dark
              ? 0
              : 1,
          cornerRadius: 10.0,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          totalSwitches: 2,

          icons: const [
            Icons.dark_mode,
            Icons.light_mode,
          ],
          iconSize: 30.0,

          activeBgColors: const [
            [Colors.black45, Colors.black26],
            [Colors.yellow, Colors.orange]
          ],
          animate:
              true, // with just animate set to true, default curve = Curves.easeIn
          curve: Curves
              .bounceInOut, // animate must be set to true when using custom curve
          onToggle: (index) {
            switch (index) {
              case 0:
                {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(Brightness.dark);
                }
                break;
              case 1:
                {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(Brightness.light);
                }
                break;
            }
          },
        ),
      ),
    );
  }
}
