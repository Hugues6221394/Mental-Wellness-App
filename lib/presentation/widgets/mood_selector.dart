import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  final List<String> moods;
  final String? selectedMood;
  final Function(String?) onChanged;

  const MoodSelector({
    super.key,
    required this.moods,
    required this.selectedMood,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: moods.map((mood) {
        return ChoiceChip(
          label: Text(mood),
          selected: selectedMood == mood,
          onSelected: (selected) => onChanged(selected ? mood : null),
        );
      }).toList(),
    );
  }
}