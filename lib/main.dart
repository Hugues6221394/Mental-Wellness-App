// lib/main.dart

import 'package:flutter/material.dart';
import 'package:mind_mate/app.dart';
import 'package:mind_mate/data/local/hive_config.dart'; // import your initHive()

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive (adapters + boxes)
  await initHive();

  // Launch the app
  runApp(const MentalWellnessApp());
}
