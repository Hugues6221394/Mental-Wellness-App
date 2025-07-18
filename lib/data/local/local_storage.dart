import 'package:hive/hive.dart';
import 'package:mind_mate/data/models/mood_model.dart';
import 'package:mind_mate/data/models/journal_model.dart';

class LocalStorage {
  static final moodBox = Hive.box<Mood>('moodBox');
  static final journalBox = Hive.box<JournalEntry>('journalBox');

  static Future<void> saveMood(Mood mood) async {
    await moodBox.add(mood);
  }

  static List<Mood> getAllMoods() {
    return moodBox.values.toList();
  }

  static Future<void> saveJournal(JournalEntry entry) async {
    await journalBox.add(entry);
  }

  static List<JournalEntry> getAllJournals() {
    return journalBox.values.toList();
  }
}
