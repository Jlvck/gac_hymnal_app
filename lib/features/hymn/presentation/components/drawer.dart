import 'package:church/features/hymn/presentation/components/drawer_list_tile.dart';
import 'package:church/features/hymn/presentation/components/social_media_tile.dart';
import 'package:church/features/hymn/presentation/screens/favorites_screen.dart';
import 'package:church/features/hymn/presentation/screens/hymn_book_screen.dart';
import 'package:church/model/navigation_item.dart';

import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  final ScrollController _scroll = ScrollController();

  MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final topPadding = MediaQuery.of(context).padding.top;
    return Semantics(
      label: "Drawer",
      child: Drawer(
        width: 3 / 4 * width,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shadowColor: Theme.of(context).colorScheme.primaryContainer,
        surfaceTintColor: Theme.of(context).colorScheme.primaryContainer,
        clipBehavior: Clip.hardEdge,
        child: Column(children: [
          Container(
            height: topPadding,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            clipBehavior: Clip.hardEdge,
          ),
          Expanded(
              child: Scrollbar(
            thumbVisibility: false,
            trackVisibility: false,
            interactive: true,
            controller: _scroll,
            thickness: 5,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(
                  overscroll: false, physics: const ClampingScrollPhysics()),
              child: ListView(
                controller: _scroll,
                padding: EdgeInsets.zero,
                children: [
                  InkWell(
                    onTap: () async {
                      final Uri url = Uri.parse("https://gacworldwide.org/");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: DrawerHeader(
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.only(left: 20),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Image.asset(
                        "assets/images/icon_image.png",
                        fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  const DrawerListTile(
                    titleName: 'Hymnbook',
                    titleIcon: Icons.music_note,
                    routeName: HymnBookScreen.routeName,
                    item: NavigationItem.hymnbook,
                  ),
                  const DrawerListTile(
                    titleName: 'Favorites',
                    titleIcon: Icons.favorite,
                    routeName: FavoritesScreen.routeName,
                    item: NavigationItem.favorites,
                  ),
                  ListTile(
                    horizontalTitleGap: 5,
                    tileColor: Colors.transparent,
                    title: Text(
                      'Follow us',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(
                        top: 5, bottom: 0, left: 25, right: 20),
                  ),
                  SocialMediaTile(
                    socialMedia: 'YouTube',
                    accountName: '@gachq',
                    socialIcon: CommunityMaterialIcons.youtube,
                    linkText: Uri.parse('https://www.youtube.com/@gachq'),
                  ),
                  SocialMediaTile(
                    socialMedia: 'Facebook',
                    accountName: 'Gac Headquarters',
                    socialIcon: CommunityMaterialIcons.facebook,
                    linkText: Uri.parse(
                        "https://web.facebook.com/Gac-Headquarters-104257107601052/?ref=page_internal"),
                  ),
                  SocialMediaTile(
                      socialMedia: 'Instagram',
                      accountName: '@gachqs',
                      socialIcon: CommunityMaterialIcons.instagram,
                      linkText: Uri.parse('https://www.instagram.com/gachqs/')),
                  SocialMediaTile(
                      socialMedia: 'Twitter',
                      accountName: '@gachqs',
                      socialIcon: CommunityMaterialIcons.twitter,
                      linkText: Uri.parse('https://twitter.com/gachqs')),
                ],
              ),
            ),
          )),
        ]),
      ),
    );
  }
}
