import 'package:church/dummy_main.dart';
import 'package:flutter/material.dart';

void main() async {
  await Future.sync(() => WidgetsFlutterBinding.ensureInitialized());
  runApp(const DummyMain());
}
