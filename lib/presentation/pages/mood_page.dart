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
  final _moods = ['😊 Happy', '😢 Sad', '😠 Angry', '😣 Stressed', '🤩 Excited'];
  String _selectedMood = '😊 Happy';
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  late List<Mood> _entries;

  @override
  void initState() {
    super.initState();
    _moodBox = Hive.box<Mood>('moodBox');
    _entries = _moodBox.values.toList().reversed.toList();
  }

  void _saveMood() {
    final mood = Mood(
      mood: _selectedMood,
      note: _noteController.text.trim(),
      date: DateTime.now(),
    );
    _moodBox.add(mood);
    setState(() {
      _entries.insert(0, mood);
      _listKey.currentState?.insertItem(0);
    });
    _noteController.clear();
    setState(() => _selectedMood = _moods[0]);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Mood saved!')),
    );
  }

  void _showAddDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionBuilder: (dialogCtx, anim1, anim2, child) => FadeTransition(
        opacity: anim1,
        child: ScaleTransition(scale: anim1, child: child),
      ),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (dialogCtx, anim1, anim2) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('🧠 Add Mood'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedMood,
                items: _moods
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
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
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(dialogCtx);
                _saveMood();
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'),
            )
          ],
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, int index, Animation<double> anim) {
    final m = _entries[index];
    return SizeTransition(
      sizeFactor: anim,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        elevation: 2,
        child: ListTile(
          leading: const Icon(Icons.mood, color: Colors.teal),
          title: Text(m.mood, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(m.note),
          trailing: Text(DateFormat.yMMMd().format(m.date)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🧠 Mood Tracker'), backgroundColor: Colors.teal),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
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
              itemBuilder: _buildItem,
            ),
          ),
        ],
      ),
    );
  }
}
