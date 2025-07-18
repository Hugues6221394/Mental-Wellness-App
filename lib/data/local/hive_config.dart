import 'package:hive_flutter/hive_flutter.dart';
import 'package:mind_mate/data/models/journal_model.dart';
import 'package:mind_mate/data/models/mood_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(MoodAdapter());
  Hive.registerAdapter(JournalEntryAdapter());

  await Hive.openBox<Mood>('moodBox');
  await Hive.openBox<JournalEntry>('journalBox');
}
