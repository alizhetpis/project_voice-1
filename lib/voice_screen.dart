
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

class VoiceScreen extends StatefulWidget{
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState()=> VoiceScreenState();
}

class VoiceScreenState extends State<VoiceScreen>{
  GoogleTranslator translator=GoogleTranslator();
  SpeechToText speechToText=SpeechToText();
  String text="Hold the button to say";
  bool isListen=false;

  void translate(){
    translator.translate(text,to: "ru").then((value){
      setState(() {
        text=(value.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
          endRadius: 75.0,
          animate: isListen,
          duration: Duration(milliseconds: 2000),
          glowColor: Colors.green,
          repeat: true,
          repeatPauseDuration: Duration(milliseconds: 100),
          showTwoGlows: true,
          child: GestureDetector(
            onTapDown: (e) async {
              if(!isListen){
                bool available=await speechToText.initialize();
                if (available){
                  setState(() {
                    isListen=true;
                    speechToText.listen(
                        onResult: (result){
                          setState(() {
                            print(result.recognizedWords);
                            text=result.recognizedWords;
                          });
                        }
                    );
                  });
                }
              }
            },
            onTapUp: (e){
              setState(() {
                isListen=false;
              });
            },
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 35,
              child: Icon(isListen ? Icons.mic: Icons.mic_none,color: Colors.white,),
            ),
          )
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.sort_rounded,color: Colors.white,),
        backgroundColor: Colors.lightBlue,
        title: Text("Voice recognition"),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
          margin: EdgeInsets.only(bottom: 150),
          child: Column(
            children: [
              Text(text,
                style: TextStyle(
                    fontSize: 24, color: Colors.black45, fontWeight: FontWeight.w600
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      translate();
                    });
                  } ,
                  child: Text("Translate the text"))
            ],
          )
      ),
    );
  }
}