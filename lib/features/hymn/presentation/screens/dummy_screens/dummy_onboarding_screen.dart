import 'package:church/features/hymn/presentation/screens/dummy_screens/dummy_english_screen.dart';
import 'package:church/features/hymn/presentation/screens/dummy_screens/dummy_yoruba_screen.dart';
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
                    builder: (context) => DummyEnglishScreen(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                child: const Text("English"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DummyYorubaScreen(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue),
                child: const Text("Yoruba"),
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
