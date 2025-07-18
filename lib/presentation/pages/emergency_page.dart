import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});
  final List<Map<String,String>> contacts = const [
    {'name':'Counselor','number':'+250788123456'},
    {'name':'Helpline','number':'112'},
    {'name':'Support','number':'+250789654321'},
  ];

  static const String routeName = '/emergency';

  Future<void> _call(String num)async{
    final uri=Uri.parse('tel:$num');
    if(await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency'), backgroundColor: Colors.red),
      body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: contacts.length,
          itemBuilder: (_,i){
            final c=contacts[i];
            return TweenAnimationBuilder<double>(
              tween: Tween(begin:0,end:1),
              duration: Duration(milliseconds:400 + i*100),
              builder:(ctx,val,child)=> Opacity(opacity:val, child: Transform.translate(offset: Offset(0,(1-val)*20), child:child)),
              child: Card(
                elevation:3,
                margin: const EdgeInsets.symmetric(vertical:6),
                child: ListTile(
                  leading: const Icon(Icons.call, color: Colors.red),
                  title: Text(c['name']!),
                  subtitle: Text(c['number']!),
                  onTap: ()=>_call(c['number']!),
                ),
              ),
            );
          }
      ),
    );
  }
}
