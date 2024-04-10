import 'package:church/features/hymn/presentation/screens/dummy_screens/dummy_onboarding_screen.dart';
import 'package:flutter/material.dart';

class DummyMain extends StatelessWidget {
  const DummyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DummyOnbaordingScreen(),
    );
  }
}
