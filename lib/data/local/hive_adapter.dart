import 'package:hive/hive.dart';
import 'package:mind_mate/data/models/mood_model.dart';
import 'package:mind_mate/data/models/journal_model.dart';

class HiveAdapter {
  static void registerAdapters() {
    Hive.registerAdapter(MoodAdapter());
    Hive.registerAdapter(JournalEntryAdapter());
  }
}
