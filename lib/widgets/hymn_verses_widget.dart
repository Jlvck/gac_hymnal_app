import 'package:flutter/material.dart';

class HymnVersesWidget extends StatelessWidget {
  final List<String> currentVerse;

  const HymnVersesWidget({super.key, required this.currentVerse});

  @override
  Widget build(BuildContext context) {
    return ListView(
      clipBehavior: Clip.hardEdge,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      children: List.generate(currentVerse.length, (i) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              currentVerse[i],
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }),
    );
  }
}
