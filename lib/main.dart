import 'package:flutter/material.dart';
import 'package:project_voice/voice_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoiceScreen(),
      theme: ThemeData(
          primaryColor: Colors.deepPurple
      ),
    );
  }
}