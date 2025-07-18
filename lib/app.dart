import 'package:flutter/material.dart';
import 'package:mind_mate/core/theme/app_theme.dart';
import 'package:mind_mate/presentation/pages/chat_page.dart';
import 'package:mind_mate/presentation/pages/emergency_page.dart';
import 'package:mind_mate/presentation/pages/home_page.dart';
import 'package:mind_mate/presentation/pages/journal_page.dart';
import 'package:mind_mate/presentation/pages/meditation_page.dart';
import 'package:mind_mate/presentation/pages/mood_dashboard_page.dart';
import 'package:mind_mate/presentation/pages/mood_page.dart';

class MentalWellnessApp extends StatelessWidget {
  const MentalWellnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Wellness App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // follows device setting
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        MoodPage.routeName: (_) => const MoodPage(),
        JournalPage.routeName: (_) => const JournalPage(),
        ChatPage.routeName: (_) => const ChatPage(),
        MeditationPage.routeName: (_) => const MeditationPage(),
        EmergencyPage.routeName: (_) => const EmergencyPage(),
        MoodDashboardPage.routeName: (_) => const MoodDashboardPage(),
      },
    );
  }
}
