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
    // Responsive grid count (2 on small, 3 on medium+)
    final crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Wellness App'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your mental wellness companion. Tap a feature to get started.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: crossAxisCount,
                  padding: const EdgeInsets.all(8),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _buildCard(
                      context,
                      'Mood Tracker',
                      Icons.mood,
                      const Color(0xFF42A5F5), // Blue
                      MoodPage.routeName,
                    ),
                    _buildCard(
                      context,
                      'Journal',
                      Icons.book,
                      const Color(0xFF66BB6A), // Green
                      JournalPage.routeName,
                    ),
                    _buildCard(
                      context,
                      'Peer Chat',
                      Icons.chat,
                      const Color(0xFFFFA726), // Orange
                      ChatPage.routeName,
                    ),
                    _buildCard(
                      context,
                      'Meditation',
                      Icons.self_improvement,
                      const Color(0xFF7E57C2), // Purple
                      MeditationPage.routeName,
                    ),
                    _buildCard(
                      context,
                      'Emergency',
                      Icons.emergency,
                      const Color(0xFFEF5350), // Red
                      EmergencyPage.routeName,
                    ),
                    _buildCard(
                      context,
                      'Mood Stats',
                      Icons.bar_chart,
                      const Color(0xFF5C6BC0), // Indigo
                      MoodDashboardPage.routeName,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      String routeName,
      ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      shadowColor: color.withOpacity(0.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: color.withOpacity(0.3),
        onTap: () => Navigator.pushNamed(context, routeName),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with soft circular background
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.15),
                ),
                padding: const EdgeInsets.all(16),
                child: Icon(icon, size: 50, color: color),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  shadows: [
                    const Shadow(
                      blurRadius: 2,
                      color: Colors.black12,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
