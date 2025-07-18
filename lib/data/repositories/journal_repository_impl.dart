import 'package:hive/hive.dart';
import 'package:mind_mate/data/models/journal_model.dart';
import 'package:mind_mate/domain/entities/journal_entity.dart';
import 'package:mind_mate/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  final Box<JournalEntry> _journalBox;

  JournalRepositoryImpl(this._journalBox);

  @override
  Future<void> addJournal(JournalEntity journal) async {
    final entry = JournalEntry.fromEntity(journal);
    await _journalBox.add(entry);
  }

  @override
  List<JournalEntity> getAllJournals() {
    return _journalBox.values.map((entry) => entry.toEntity()).toList();
  }

  @override
  Future<void> deleteJournal(int index) async {
    await _journalBox.deleteAt(index);
  }

  @override
  Future<void> updateJournal(int index, JournalEntity journal) async {
    final entry = JournalEntry.fromEntity(journal);
    await _journalBox.putAt(index, entry);
  }

  @override
  Future<void> clearJournals() async {
    await _journalBox.clear();
  }
}
