import 'package:flutter/material.dart';
import 'package:gac_hymnal_app/model/hymn.dart';

class MainTextField extends StatefulWidget {
  //The Longer textField is taged Title
  //The Shorter textField is taged number

  final List<Hymn> foundHymns;
  final TextEditingController enteredHymnTitle;
  final TextEditingController enteredHymnNumber;
  final Function runFilter;
  final Function onTapTitle;
  final Function onChangedTitle;
  final Function onTapNumber;
  final Function onChangedNumber;
  final Function onSubmittedNumber;
  final Function reset;

  const MainTextField(
      {super.key,
      required this.foundHymns,
      required this.enteredHymnTitle,
      required this.enteredHymnNumber,
      required this.runFilter,
      required this.onTapTitle,
      required this.onChangedTitle,
      required this.onTapNumber,
      required this.onChangedNumber,
      required this.onSubmittedNumber,
      required this.reset});

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: mediaQuery.size.width * 3 / 4),
          child: Container(
            margin: const EdgeInsets.only(
              left: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: SizedBox(
              height: 40,
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.primary,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                maxLines: 1,
                minLines: 1,
                strutStyle: const StrutStyle(
                  forceStrutHeight: true,
                ),
                style: Theme.of(context).primaryTextTheme.titleMedium,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                onTap: () => widget.onTapTitle(),
                controller: widget.enteredHymnTitle,
                onChanged: (value) => widget.onChangedTitle(value),
                keyboardType: TextInputType.text,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  isCollapsed: true,
                  isDense: true,
                  contentPadding: const EdgeInsets.only(left: 8, right: 8),
                  hintStyle: Theme.of(context)
                      .primaryTextTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                  hintText: 'Search....',
                  hintMaxLines: 1,
                  hintTextDirection: TextDirection.ltr,
                  prefixIcon: FittedBox(
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                      size: 50,
                    ),
                  ),
                  suffix: Semantics(
                    label: "Clear Button",
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      color: Theme.of(context).colorScheme.primary,
                      icon: Icon(
                        Icons.cancel,
                        size: 22,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      tooltip: "clear input",
                      onPressed: () {
                        widget.enteredHymnTitle.clear();
                        widget.reset();
                      },
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: mediaQuery.size.width * 0.75 / 4),
          child: Container(
            margin: const EdgeInsets.only(right: 15, left: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 40,
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.primary,
                maxLines: 1,
                minLines: 1,
                style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                onTap: () => widget.onTapNumber(),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: false,
                  signed: false,
                ),
                onChanged: (value) => widget.onChangedNumber(value),
                onSubmitted: (submit) =>
                    widget.onSubmittedNumber(submit, widget.foundHymns),
                controller: widget.enteredHymnNumber,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.only(top: 8, left: 5, right: 2),
                  hintText: '#',
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 22),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
