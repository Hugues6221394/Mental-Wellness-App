import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mind_mate/data/models/mood_model.dart';
import 'package:intl/intl.dart';

class MoodDashboardPage extends StatelessWidget {
  static const String routeName = '/mood-dashboard';

  const MoodDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Mood>('moodBox');
    final moods = box.values.toList();

    final total = moods.length;
    final freq = <String, int>{};
    for (var m in moods) freq[m.mood] = (freq[m.mood] ?? 0) + 1;

    return Scaffold(
      appBar: AppBar(title: const Text('Mood Dashboard'), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: total == 0
            ? const Center(child: Text('No data to display.'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total logs: $total', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ...freq.entries.map((e) {
              final percent = (e.value / total * 100).round();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(child: Text('${e.key}: $percent%')),
                    SizedBox(width: percent * 2.0, height: 20, child: DecoratedBox(decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(4))))
                  ],
                ),
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            )
          ],
        ),
      ),
    );
  }
}
