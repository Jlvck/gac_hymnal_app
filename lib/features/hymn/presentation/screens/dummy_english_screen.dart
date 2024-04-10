import 'package:church/features/hymn/presentation/screens/hymn_english_screen.dart';
import 'package:flutter/material.dart';

class DummyEnglishScreen extends StatelessWidget {
  const DummyEnglishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/english.png",
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    "English",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HymnEnglishScreen()));
            },
            isThreeLine: true,
            title: Text("Hymn 001"),
            subtitle: Text("Great Shepherd of thy peopl..."),
          )
        ],
      ),
    );
  }
}
