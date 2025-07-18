import 'package:flutter/material.dart';

class MeditationPage extends StatefulWidget {
  static const String routeName = '/meditation';

  const MeditationPage({super.key});
  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> with TickerProviderStateMixin {
  bool _playing = false;
  int _sec = 60;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  void _tick() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!_playing) return;
      if (_sec>0) {
        setState(()=>_sec--);
        _tick();
      } else {
        setState(()=>_playing=false);
        _sec=60;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meditation'), backgroundColor: Colors.purple),
      body: FadeTransition(
        opacity: _fadeController..forward(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset('assets/meditation.gif', height:200, fit: BoxFit.cover),
            const SizedBox(height:16),
            const Text('Breathe in 4s • Hold 4s • Out 4s', style: TextStyle(fontSize:16)),
            const SizedBox(height:16),
            Text('${(_sec~/60).toString().padLeft(2,'0')}:${(_sec%60).toString().padLeft(2,'0')}', style: const TextStyle(fontSize:32)),
            const SizedBox(height:16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: (){
                setState(()=>_playing=!_playing);
                if(_playing) _tick();
              },
              child: Text(_playing?'Pause':'Start'),
            )
          ]),
        ),
      ),
    );
  }
}
