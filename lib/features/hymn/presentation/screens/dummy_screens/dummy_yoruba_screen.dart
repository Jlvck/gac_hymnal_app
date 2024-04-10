import 'package:church/features/hymn/presentation/screens/dummy_screens/hymn_yoruba_screen.dart';
import 'package:flutter/material.dart';

class DummyYorubaScreen extends StatelessWidget {
  const DummyYorubaScreen({super.key});

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/yoruba.png",
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    "Yoruba",
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
                  MaterialPageRoute(builder: (context) => HymnYorubaScreen()));
            },
            isThreeLine: true,
            title: Text("Hymn 001"),
            subtitle: Text("Olus’agutan eni Re"),
          )
        ],
      ),
    );
  }
}
