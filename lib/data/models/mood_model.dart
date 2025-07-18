import 'package:hive/hive.dart';
import 'package:mind_mate/domain/entities/mood_entity.dart';

part 'mood_model.g.dart';

@HiveType(typeId: 0)
class Mood extends HiveObject {
  @HiveField(0)
  String mood;

  @HiveField(1)
  String note;

  @HiveField(2)
  DateTime date;

  Mood({
    required this.mood,
    required this.note,
    required this.date,
  });

  factory Mood.fromEntity(MoodEntity entity) {
    return Mood(
      mood: entity.mood,
      note: entity.note,
      date: entity.date,
    );
  }

  MoodEntity toEntity() {
    return MoodEntity(
      mood: mood,
      note: note,
      date: date,
    );
  }
}
