import 'package:flutter/material.dart';
import 'package:mind_mate/domain/entities/mood_entity.dart';
import 'package:mind_mate/domain/repositories/mood_repository.dart';

class MoodProvider with ChangeNotifier {
  final MoodRepository _repository;

  MoodProvider(this._repository);

  List<MoodEntity> _moods = [];
  List<MoodEntity> get moods => _moods;

  Future<void> loadMoods() async {
    _moods = _repository.getAllMoods();
    notifyListeners();
  }

  Future<void> addMood(MoodEntity mood) async {
    await _repository.addMood(mood);
    await loadMoods();
  }
}