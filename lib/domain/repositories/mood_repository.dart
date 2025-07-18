import 'package:mind_mate/domain/entities/mood_entity.dart';

abstract class MoodRepository {
  Future<void> addMood(MoodEntity mood);
  List<MoodEntity> getAllMoods();
  Future<void> deleteMood(int index);
  Future<void> updateMood(int index, MoodEntity mood);
  Future<void> clearMoods();
}
