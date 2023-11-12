import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/navigation_provider.dart';
import '../model/navigation_item.dart';
import '../screens/hymn_book_screen.dart';
import '../screens/favorites_screen.dart';

class MainDrawer extends StatelessWidget {
  final ScrollController _scroll = ScrollController();

  MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final topPadding = MediaQuery.of(context).padding.top;
    return Drawer(
      width: 3 / 4 * width,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      child: Column(children: [
        Expanded(
            child: Scrollbar(
          thumbVisibility: false,
          trackVisibility: false,
          interactive: true,
          controller: _scroll,
          thickness: 5,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView(
              controller: _scroll,
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(color: Colors.white),
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'images/church_image_drawer.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                drawerListTile('Hymnbook', Icons.music_note,
                    HymnBookScreen.routeName, NavigationItem.hymnbook, context),
                drawerListTile(
                    'Favorites',
                    Icons.favorite,
                    FavoritesScreen.routeName,
                    NavigationItem.favorites,
                    context),
                ListTile(
                  horizontalTitleGap: 5,
                  tileColor: Colors.white,
                  title: Text(
                    'Follow us',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                  contentPadding: const EdgeInsets.only(
                      top: 5, bottom: 0, left: 25, right: 20),
                ),
                drawerFollowWidget(
                  context,
                  'YouTube',
                  '@gachq',
                  CommunityMaterialIcons.youtube,
                  Uri.parse('https://www.youtube.com/@gachq'),
                ),
                drawerFollowWidget(
                  context,
                  'Facebook',
                  'Gac Headquarters',
                  CommunityMaterialIcons.facebook,
                  Uri.parse(
                      "https://web.facebook.com/Gac-Headquarters-104257107601052/?ref=page_internal"),
                ),
                drawerFollowWidget(
                    context,
                    'Instagram',
                    '@gachqs',
                    CommunityMaterialIcons.instagram,
                    Uri.parse('https://www.instagram.com/gachqs/')),
                drawerFollowWidget(
                    context,
                    'Twitter',
                    '@gachqs',
                    CommunityMaterialIcons.twitter,
                    Uri.parse('https://twitter.com/gachqs')),
              ],
            ),
          ),
        )),
      ]),
    );
  }

  _launchURL(Uri urltext) async {
    final url = urltext;
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  ListTile drawerListTile(String tileName, IconData tileIcon, String routeName,
      NavigationItem item, BuildContext ctx) {
    final provider = Provider.of<NavigationProvider>(ctx);
    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;
    final colorTheme = Theme.of(ctx).secondaryHeaderColor;

    return ListTile(
      tileColor: Colors.white,
      selected: isSelected,
      selectedColor: colorTheme,
      enabled: true,
      iconColor: Theme.of(ctx).primaryColor,
      hoverColor: Colors.black54,
      splashColor: Colors.black54,
      selectedTileColor: Colors.white,
      horizontalTitleGap: 5,
      contentPadding:
          const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
      leading: Icon(
        tileIcon,
        size: 30,
      ),
      onTap: () {
        provider.setNavigationItem(item);
        Navigator.of(ctx).pushReplacementNamed(
          routeName,
        );
      },
      title: Text(
        tileName,
        style: TextStyle(
            color: isSelected ? colorTheme : Theme.of(ctx).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  ListTile drawerFollowWidget(
    BuildContext ctx,
    String socialTitle,
    String displayText,
    IconData socialIcon,
    Uri linkText,
  ) {
    return ListTile(
      tileColor: Colors.white,
      iconColor: Theme.of(ctx).primaryColor,
      splashColor: Colors.black54,
      horizontalTitleGap: 5,
      minVerticalPadding: 1,
      contentPadding:
          const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
      leading: Icon(
        socialIcon,
        size: 30,
      ),
      onTap: () {
        _launchURL(linkText);
      },
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: linkText.toString())).then((_) {
          Navigator.of(ctx).pop();
          ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
              content: Text(
            'Link copied to your clipboard',
            style: TextStyle(fontWeight: FontWeight.bold),
          )));
        });
      },
      title: Text(
        socialTitle,
        style: TextStyle(
            color: Theme.of(ctx).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        displayText,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(color: Theme.of(ctx).primaryColor),
      ),
    );
  }
}
