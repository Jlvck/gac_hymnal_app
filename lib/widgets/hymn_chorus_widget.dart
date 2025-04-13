import 'package:flutter/material.dart';

class HymnChorusWidget extends StatelessWidget {
  final List<String> currentChorus;
  const HymnChorusWidget({
    super.key,
    required this.currentChorus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: List.generate(currentChorus.length, (index) {
              return Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentChorus[index],
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
