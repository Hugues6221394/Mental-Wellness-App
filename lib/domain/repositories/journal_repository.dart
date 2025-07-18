import 'package:mind_mate/domain/entities/journal_entity.dart';

abstract class JournalRepository {
  Future<void> addJournal(JournalEntity journal);
  List<JournalEntity> getAllJournals();
  Future<void> deleteJournal(int index);
  Future<void> updateJournal(int index, JournalEntity journal);
  Future<void> clearJournals();
}
