import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import '../model/navigation_item.dart';

class DrawerListTile extends StatelessWidget {
  final String titleName;
  final String routeName;
  final IconData titleIcon;
  final NavigationItem item;

  const DrawerListTile(
      {super.key,
      required this.titleName,
      required this.routeName,
      required this.titleIcon,
      required this.item});

  @override
  Widget build(BuildContext context) {
    final NavigationItem currentItem = Provider.of<NavigationProvider>(
      context,
    ).navigationItem;
    final isSelected = item == currentItem;
    return ListTile(
      tileColor: Colors.white,
      selected: isSelected,
      selectedColor: Theme.of(context).secondaryHeaderColor,
      enabled: true,
      iconColor: Theme.of(context).primaryColor,
      hoverColor: Colors.black54,
      splashColor: Colors.black54,
      selectedTileColor: Colors.white,
      horizontalTitleGap: 5,
      contentPadding:
          const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
      leading: Icon(
        titleIcon,
        size: 30,
      ),
      onTap: () {
        Provider.of<NavigationProvider>(context, listen: false)
            .setNavigationItem(item);
        Navigator.of(context).pushReplacementNamed(
          routeName,
        );
      },
      title: Text(
        titleName,
        style: TextStyle(
            color: isSelected
                ? Theme.of(context).secondaryHeaderColor
                : Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
