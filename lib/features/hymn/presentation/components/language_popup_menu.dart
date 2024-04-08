import 'package:church/features/hymn/presentation/controllers/language_provider.dart';
import 'package:church/model/language_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LanguagePopUpMenu extends StatelessWidget {
  final Function? clearControllers;
  const LanguagePopUpMenu({super.key, this.clearControllers});
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Language Popup Menu",
      child: PopupMenuButton(
        enableFeedback: true,
        icon: const Icon(Icons.language),
        color: Theme.of(context).colorScheme.background,
        onSelected: (value) {
          if (value !=
              Provider.of<LanguageProvider>(context, listen: false)
                  .currentItem) {
            Provider.of<LanguageProvider>(
              context,
              listen: false,
            ).setLanguageItem(value);
            if (clearControllers != null) {
              clearControllers!();
            }
          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: LanguageItem.yoruba,
              child: Semantics(
                label: "Yoruba Language",
                child: Text(
                  'Yoruba',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
            PopupMenuItem(
                value: LanguageItem.english,
                child: Semantics(
                  label: "English Language",
                  child: Text(
                    'English',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ))
          ];
        },
      ),
    );
  }
}
