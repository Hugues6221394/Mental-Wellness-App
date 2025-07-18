import 'package:hive/hive.dart';
import 'package:mind_mate/data/models/mood_model.dart';
import 'package:mind_mate/domain/entities/mood_entity.dart';
import 'package:mind_mate/domain/repositories/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {
  final Box<Mood> _moodBox;

  MoodRepositoryImpl(this._moodBox);

  @override
  Future<void> addMood(MoodEntity moodEntity) async {
    final mood = Mood.fromEntity(moodEntity);
    await _moodBox.add(mood);
  }

  @override
  List<MoodEntity> getAllMoods() {
    return _moodBox.values.map((mood) => mood.toEntity()).toList();
  }

  @override
  Future<void> deleteMood(int index) async {
    await _moodBox.deleteAt(index);
  }

  @override
  Future<void> updateMood(int index, MoodEntity moodEntity) async {
    final mood = Mood.fromEntity(moodEntity);
    await _moodBox.putAt(index, mood);
  }

  @override
  Future<void> clearMoods() async {
    await _moodBox.clear();
  }
}
