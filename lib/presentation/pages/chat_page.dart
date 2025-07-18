import 'dart:math';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = '/chat';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _ctrl = TextEditingController();
  final List<Map<String, String>> _msgs = [];
  late final String _nickname;

  @override
  void initState() {
    super.initState();
    final names = ['StarGazer','QuietMind','HopeSeeker','SoulBuddy','ZenFriend'];
    _nickname = names[Random().nextInt(names.length)];
    _msgs.add({'sender': 'System', 'text': 'Welcome, $_nickname!'});
  }

  void _send() {
    final t = _ctrl.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _msgs.add({'sender': _nickname, 'text': t});
      _ctrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Peer Support Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _msgs.length,
              itemBuilder: (_, i) {
                final m = _msgs[i];
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 300),
                    )..forward(),
                    curve: Curves.easeIn,
                  ),
                  child: Align(
                    alignment: m['sender']==_nickname ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: m['sender']==_nickname ? Colors.orange[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('${m['sender']}: ${m['text']}'),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(
                      hintText: 'Say something...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.send), onPressed: _send),
              ],
            ),
          )
        ],
      ),
    );
  }
}
