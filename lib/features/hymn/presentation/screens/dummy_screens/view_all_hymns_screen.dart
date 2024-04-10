import 'package:church/features/hymn/presentation/screens/dummy_screens/view_hymn_screen.dart';
import 'package:flutter/material.dart';

enum AppSupportedLanguages {
  english(
    "English",
    "assets/images/english.png",
  ),
  yoruba(
    "Yoruba",
    "assets/images/yoruba.png",
  );

  const AppSupportedLanguages(
    this.description,
    this.imageUrl,
  );
  final String description;
  final String imageUrl;
}

typedef EachHymnOverview = ({String chapter, String snippet});

List<EachHymnOverview> englishHymnData = [
  (chapter: "001", snippet: "Great Shepherd of thy peopl..."),
  (chapter: "002", snippet: "Holy Father, hear me"),
  (chapter: "003", snippet: "Jesus, Lover of my soul"),
  (chapter: "004", snippet: "Once more the sun is beamin..."),
  (chapter: "005", snippet: "There is sunshine in the va..."),
  (chapter: "006", snippet: "Come down, O love Divine,"),
  (chapter: "007", snippet: "Father of all, Thy care we..."),
  (chapter: "008", snippet: "Mercy and Judgement will I s..."),
  (chapter: "009", snippet: "Glory to Thee, my God, this..."),
  (chapter: "010", snippet: "The sun is sinking fast,"),
  (chapter: "010", snippet: "The sun is sinking fast,"),
];

List<EachHymnOverview> yorubaHymnData = [
  (chapter: "001", snippet: "Olus’agutan eni Re"),
  (chapter: "002", snippet: "Ife orun alali’egbe"),
  (chapter: "003", snippet: "Oluwa mi, mo njade lo,"),
  (chapter: "004", snippet: "Wa s’odo mi, Oluwa mi,"),
  (chapter: "005", snippet: "Krist’f’ogo Re ka aye,"),
  (chapter: "006", snippet: "Wa s’adura ooro,"),
  (chapter: "007", snippet: "Imole oro didun yi,"),
  (chapter: "008", snippet: "Jesu, orun ododo,"),
  (chapter: "009", snippet: "Baba mi, gbo t’emi,"),
  (chapter: "010", snippet: "Lekan si, bi orun ti nran,..."),
  (chapter: "010", snippet: "Lekan si, bi orun ti nran,..."),
  (chapter: "011", snippet: "Je ki nsun mo O l’ojojumo"),
];

class ViewAllHymnsScreen extends StatelessWidget {
  final AppSupportedLanguages language;
  const ViewAllHymnsScreen({
    required this.language,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<EachHymnOverview> allHymns =
        language == AppSupportedLanguages.english
            ? englishHymnData
            : yorubaHymnData;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    language.imageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    language.description,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allHymns.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ViewHymnScreen()));
                  },
                  isThreeLine: true,
                  title: Text(allHymns[index].chapter),
                  subtitle: Text(allHymns[index].snippet),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
