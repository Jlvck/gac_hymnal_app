import 'package:church/features/hymn/presentation/screens/dummy_screens/view_all_hymns_screen.dart';
import 'package:flutter/material.dart';

class DummyOnbaordingScreen extends StatelessWidget {
  const DummyOnbaordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/dummy_onboarding.png",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewAllHymnsScreen(
                      language: AppSupportedLanguages.english,
                    ),
                  ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                child: Text(AppSupportedLanguages.english.description),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewAllHymnsScreen(
                      language: AppSupportedLanguages.yoruba,
                    ),
                  ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue),
                child: Text(AppSupportedLanguages.yoruba.description),
              ),
            ],
          ),
        ),
        const Positioned(
            bottom: 20,
            child: Text(
              "SELECT YOUR PREFERRED LANGUAGE",
              style: TextStyle(color: Colors.white),
            ))
      ],
    ));
  }
}
