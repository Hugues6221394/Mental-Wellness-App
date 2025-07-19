// lib/presentation/pages/mood_page.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mind_mate/data/models/mood_model.dart';

class MoodPage extends StatefulWidget {
  static const String routeName = '/mood';

  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> with TickerProviderStateMixin {
  late Box<Mood> _moodBox;
  final _noteController = TextEditingController();
  final _listKey = GlobalKey<AnimatedListState>();

  final List<String> _moods = [
    '😊 Happy', '😢 Sad', '😠 Angry', '😣 Stressed', '🤩 Excited'
  ];
  late String _selectedMood;
  late List<Mood> _entries;

  @override
  void initState() {
    super.initState();
    _moodBox = Hive.box<Mood>('moodBox');
    _entries = _moodBox.values.toList().reversed.toList();
    _selectedMood = _moods[0];
  }

  void _saveMood({Mood? editingMood}) {
    final moodEntry = Mood(
      mood: _selectedMood,
      note: _noteController.text.trim(),
      date: DateTime.now(),
    );

    if (editingMood != null) {
      final key = editingMood.key;
      if (key != null) {
        _moodBox.put(key, moodEntry);
        setState(() {
          final idx = _entries.indexWhere((m) => m.key == key);
          if (idx != -1) {
            _entries[idx] = moodEntry;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Mood updated!')),
        );
      } else {
        print('Error: editingMood key is null');
      }
    } else {
      _moodBox.add(moodEntry);
      setState(() {
        _entries.insert(0, moodEntry);
        _listKey.currentState?.insertItem(0);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Mood saved!')),
      );
    }

    _noteController.clear();
    setState(() => _selectedMood = _moods[0]);
  }

  void _deleteMood(int index) {
    final mood = _entries[index];
    _moodBox.delete(mood.key);
    setState(() {
      _entries.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
            (context, animation) => _buildMoodTile(context, index, animation),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🗑️ Mood deleted')),
    );
  }

  void _showAddDialog({Mood? editingMood}) {
    if (editingMood != null) {
      _selectedMood = editingMood.mood;
      _noteController.text = editingMood.note;
    } else {
      _selectedMood = _moods[0];
      _noteController.clear();
    }

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionBuilder: (ctx, anim1, anim2, child) => FadeTransition(
        opacity: anim1,
        child: ScaleTransition(scale: anim1, child: child),
      ),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (ctx, a1, a2) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(editingMood != null ? '✏️ Edit Mood' : '🧠 Add Mood'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedMood,
                items: _moods
                    .map((mood) => DropdownMenuItem(
                  value: mood,
                  child: Text(mood),
                ))
                    .toList(),
                onChanged: (v) => setState(() => _selectedMood = v!),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Note (optional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit_note),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _saveMood(editingMood: editingMood);
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'),
            )
          ],
        );
      },
    );
  }

  IconData _getMoodIcon(String mood) {
    if (mood.contains('Happy')) return Icons.sentiment_satisfied;
    if (mood.contains('Sad')) return Icons.sentiment_dissatisfied;
    if (mood.contains('Angry')) return Icons.sentiment_very_dissatisfied;
    if (mood.contains('Stressed')) return Icons.sentiment_neutral;
    if (mood.contains('Excited')) return Icons.sentiment_very_satisfied;
    return Icons.mood;
  }

  Widget _buildMoodTile(BuildContext context, int index, Animation<double> animation) {
    final mood = _entries[index];
    return SizeTransition(
      sizeFactor: animation,
      child: Dismissible(
        key: ValueKey(mood.key),
        background: Container(
          color: Colors.blue,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.edit, color: Colors.white),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            final bool confirm = await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Confirm Delete'),
                content: const Text('Are you sure you want to delete this mood?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
            if (confirm) {
              _deleteMood(index);
            }
            return confirm;
          } else if (direction == DismissDirection.startToEnd) {
            _showAddDialog(editingMood: mood);
            return false;
          }
          return false;
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          elevation: 2,
          child: ListTile(
            onLongPress: () => _showOptions(index),
            leading: Icon(_getMoodIcon(mood.mood), color: Colors.teal),
            title: Text(mood.mood, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(mood.note),
            trailing: Text(DateFormat.yMMMd().format(mood.date)),
          ),
        ),
      ),
    );
  }

  void _showOptions(int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Edit Mood'),
              onTap: () {
                Navigator.pop(ctx);
                _showAddDialog(editingMood: _entries[index]);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Mood'),
              onTap: () {
                Navigator.pop(ctx);
                _deleteMood(index);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧠 Mood Tracker'),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const Text('Your Mood History', style: TextStyle(fontSize: 18)),
          const Divider(),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _entries.length,
              itemBuilder: _buildMoodTile,
            ),
          ),
        ],
      ),
    );
  }
}
