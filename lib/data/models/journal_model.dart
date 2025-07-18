import 'package:hive/hive.dart';
import 'package:mind_mate/domain/entities/journal_entity.dart';

part 'journal_model.g.dart';

@HiveType(typeId: 1)
class JournalEntry extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late DateTime date;

  JournalEntry({
    required this.title,
    required this.content,
    required this.date,
  });

  // Convert from domain entity
  factory JournalEntry.fromEntity(JournalEntity entity) {
    return JournalEntry(
      title: entity.title,
      content: entity.content,
      date: entity.date,
    );
  }

  // Convert to domain entity
  JournalEntity toEntity() {
    return JournalEntity(
      title: title,
      content: content,
      date: date,
    );
  }
}
