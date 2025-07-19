import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mind_mate/data/models/journal_model.dart';

class JournalPage extends StatefulWidget {
  static const String routeName = '/journal';

  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> with TickerProviderStateMixin {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  late List<JournalEntry> _entries;

  @override
  void initState() {
    super.initState();
    final box = Hive.box<JournalEntry>('journalBox');
    _entries = box.values.toList().reversed.toList();
  }

  void _addEntryDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('📝 New Journal Entry'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _contentController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    prefixIcon: Icon(Icons.notes),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                _titleController.clear();
                _contentController.clear();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel, color: Colors.redAccent),
              label: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: _saveJournal,
              icon: const Icon(Icons.save),
              label: const Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveJournal() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    if (title.isEmpty || content.isEmpty) return;

    final box = Hive.box<JournalEntry>('journalBox');
    final newEntry = JournalEntry(
      title: title,
      content: content,
      date: DateTime.now(),
    );

    box.add(newEntry);

    setState(() {
      _entries.insert(0, newEntry);
      _listKey.currentState?.insertItem(0);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ Journal saved successfully"),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );

    _titleController.clear();
    _contentController.clear();
    Navigator.pop(context);
  }

  Widget _buildAnimatedItem(BuildContext context, int index, Animation<double> animation) {
    final entry = _entries[index];

    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: const Icon(Icons.bookmark, color: Colors.deepPurple),
          title: Text(
            entry.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(entry.content),
          trailing: Text(
            DateFormat.yMMMd().format(entry.date),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📖 Journal'),
        backgroundColor: Colors.deepPurple,
        elevation: 3,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntryDialog,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder<Box<JournalEntry>>(
        valueListenable: Hive.box<JournalEntry>('journalBox').listenable(),
        builder: (_, box, __) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                'No journal entries yet. Start writing! 📝',
                style: TextStyle(color: Colors.black54),
              ),
            );
          }

          return AnimatedList(
            key: _listKey,
            initialItemCount: _entries.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: _buildAnimatedItem,
          );
        },
      ),
    );
  }
}
