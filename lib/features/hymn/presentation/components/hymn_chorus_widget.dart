import 'package:church/features/hymn/presentation/controllers/language_provider.dart';
import 'package:church/model/language_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HymnChorusWidget extends StatelessWidget {
  final List<String> currentChorus;
  const HymnChorusWidget({
    super.key,
    required this.currentChorus,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageItem currentLanguage =
        Provider.of<LanguageProvider>(context, listen: true).currentItem;

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //Text for chorus or Egbe
          Text(
            currentLanguage == LanguageItem.yoruba ? 'Ègbè' : 'Chorus',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.onBackground),
          ),
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
                        color: Theme.of(context).colorScheme.onBackground),
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
