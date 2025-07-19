import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mind_mate/data/models/mood_model.dart';
import 'package:intl/intl.dart';

class MoodDashboardPage extends StatefulWidget {
  static const String routeName = '/mood-dashboard';

  const MoodDashboardPage({super.key});

  @override
  State<MoodDashboardPage> createState() => _MoodDashboardPageState();
}

class _MoodDashboardPageState extends State<MoodDashboardPage> {
  late Box<Mood> moodBox;

  @override
  void initState() {
    super.initState();
    moodBox = Hive.box<Mood>('moodBox');
  }

  void _editMood(int index, Mood mood) {
    final controllerMood = TextEditingController(text: mood.mood);
    final controllerNote = TextEditingController(text: mood.note ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Mood Entry'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controllerMood,
              decoration: const InputDecoration(labelText: 'Mood'),
            ),
            TextField(
              controller: controllerNote,
              decoration: const InputDecoration(labelText: 'Note'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedMood = Mood(
                mood: controllerMood.text,
                note: controllerNote.text,
                date: mood.date, // Use existing date
              );
              moodBox.putAt(index, updatedMood);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteMood(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this mood entry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              moodBox.deleteAt(index);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final moods = moodBox.values.toList();
    final total = moods.length;

    final freq = <String, int>{};
    for (var m in moods) freq[m.mood] = (freq[m.mood] ?? 0) + 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Dashboard'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: total == 0
            ? const Center(child: Text('No mood entries yet.'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Logs: $total', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...freq.entries.map((e) {
              final percent = (e.value / total * 100).round();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(child: Text('${e.key}: $percent%')),
                    SizedBox(
                      width: percent * 2.0,
                      height: 20,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
            const Divider(height: 30),
            const Text('All Entries:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: moods.length,
                itemBuilder: (_, i) {
                  final mood = moods[i];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text('${mood.mood}'),
                      subtitle: Text(DateFormat.yMd().add_jm().format(mood.date)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editMood(i, mood),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteMood(i),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
