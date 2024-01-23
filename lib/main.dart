import 'package:flutter/material.dart';
import './run_app.dart';

void main() async {
  await Future.sync(() => WidgetsFlutterBinding.ensureInitialized());
  runApp(const RunApp());
}
