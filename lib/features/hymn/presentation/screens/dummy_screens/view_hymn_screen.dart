import 'package:church/features/hymn/presentation/components/hymn_chorus_widget.dart';
import 'package:church/features/hymn/presentation/components/hymn_verses_widget.dart';
import 'package:church/features/hymn/presentation/screens/dummy_screens/view_all_hymns_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Verse {
  final List<String> lines;
  Verse(this.lines);
}

class Chorus {
  List<String> lines;
  Chorus(this.lines);
}

class Hymn {
  final int hymnNumber;
  final List<Verse> verses;
  final Chorus? chorus;
  final bool isFavorite;
  final AppSupportedLanguages language;

  Hymn({
    required this.hymnNumber,
    required this.verses,
    this.chorus,
    required this.language,
    this.isFavorite = false,
  });
}

class ViewHymnScreen extends StatelessWidget {
  const ViewHymnScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hymn = Hymn(
      hymnNumber: 1,
      verses: [
        Verse([
          "Great shepherd of thy people hear",
          "Thy presence now display,",
          "As Thou hast giv’n a place for pray’r",
          "So give us hearts to pray."
        ]),
        Verse([
          "Show us some token of thy Love",
          "Our Fainting hope to raise",
          "And pour thy Blessing from above",
          "That we may render praise"
        ]),
        Verse([
          "Within these walls let holy peace",
          "And love and concord dwell,",
          "Here give the troubled conscience ease",
          "The wounded spirits heal."
        ]),
        Verse([
          "The hearing ear, the seeing eye,",
          "The contrite heart bestow:",
          "And shine upon us from on high",
          "That we in grace may grow."
        ])
      ],
      chorus: Chorus(["chorus", "chorus"]),
      language: AppSupportedLanguages.english,
    );

    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.exit_to_app),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
          title: Text("Hymn ${hymn.hymnNumber}"),
        ),
        // body: Center(child: Text("This is English Hymn")),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: hymn.verses.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 20,
                                width: 20,
                                margin: EdgeInsets.only(left: 20),
                                child: Text((index + 1).toString())),
                            Expanded(
                              child: EachHymnVerseWidget(
                                  currentVerse: hymn.verses[index].lines),
                            ),
                          ],
                        ),
                        if (hymn.chorus != null)
                          HymnChorusWidget(currentChorus: hymn.chorus!.lines)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
