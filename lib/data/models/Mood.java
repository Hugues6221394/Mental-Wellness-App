import 'package:hive/hive.dart';

part 'mood_model.g.dart';

@HiveType(typeId: 0)
class Mood extends HiveObject {
  @HiveField(0)
  final String moodType;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String? note;

  Mood({
    required this.moodType,
    required this.date,
    this.note,
  });
}
