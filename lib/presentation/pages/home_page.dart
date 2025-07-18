import 'package:flutter/material.dart';
import 'package:mind_mate/presentation/pages/chat_page.dart';
import 'package:mind_mate/presentation/pages/emergency_page.dart';
import 'package:mind_mate/presentation/pages/journal_page.dart';
import 'package:mind_mate/presentation/pages/meditation_page.dart';
import 'package:mind_mate/presentation/pages/mood_page.dart';
import 'package:mind_mate/presentation/pages/mood_dashboard_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mental Wellness App')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildCard(context, 'Mood Tracker', Icons.mood, Colors.blue, MoodPage.routeName),
          _buildCard(context, 'Journal', Icons.book, Colors.green, JournalPage.routeName),
          _buildCard(context, 'Peer Chat', Icons.chat, Colors.orange, ChatPage.routeName),
          _buildCard(context, 'Meditation', Icons.self_improvement, Colors.purple, MeditationPage.routeName),
          _buildCard(context, 'Emergency', Icons.emergency, Colors.red, EmergencyPage.routeName),
          _buildCard(context, 'Mood Stats', Icons.bar_chart, Colors.indigo, MoodDashboardPage.routeName),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color, String routeName) {
    return Card(
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Navigator.pushNamed(context, routeName),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
