import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../model/language_item.dart';

class LanguagePopUpMenu extends StatelessWidget {
  const LanguagePopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      enableFeedback: true,
      icon: const Icon(Icons.language),
      onSelected: (value) =>
          Provider.of<LanguageProvider>(context, listen: false)
              .setLanguageItem(value),
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: LanguageItem.yoruba,
            child: Text('Yoruba'),
          ),
          PopupMenuItem(value: LanguageItem.english, child: Text('English'))
        ];
      },
    );
  }
}
