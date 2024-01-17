import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

class SocialMediaTile extends StatelessWidget {
  final String socialMedia;
  final String accountName;

  final IconData socialIcon;
  final Uri linkText;
  const SocialMediaTile(
      {super.key,
      required this.socialMedia,
      required this.accountName,
      required this.socialIcon,
      required this.linkText});

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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.transparent,
      selectedTileColor: Colors.transparent,
      iconColor: Theme.of(context).colorScheme.primary,
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
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            'Link copied to your clipboard',
            style: TextStyle(fontWeight: FontWeight.bold),
          )));
        });
      },
      title: Text(
        socialMedia,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        accountName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
