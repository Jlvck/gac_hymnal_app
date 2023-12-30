import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../model/language_item.dart';

class LanguagePopUpMenu extends StatelessWidget {
  final Function? clearControllers;
  const LanguagePopUpMenu({super.key, this.clearControllers});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      enableFeedback: true,
      icon: const Icon(Icons.language),
      onSelected: (value) {
        Provider.of<LanguageProvider>(
          context,
          listen: false,
        ).setLanguageItem(value);
        if (clearControllers != null) {
          clearControllers!();
        }
      },
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
