import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:final_app/main.dart';
import 'package:final_app/speech_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = 'Press the button and start speaking';
  bool isListening = false;
  var a = [];
  var imgpath = 'default';
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            MyApp.title,
            textScaleFactor: 1.1,
          ),
          centerTitle: true,
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "images/" + imgpath + ".jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 40),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          endRadius: 80,
          glowColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 40),
            onPressed: toggleRecording,
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              display(text);
            });
          }
        },
      );

  display(String txt) async {
    var ab = txt.toLowerCase();
    a = ab.split("");
    for (var i = 0; i < a.length; i++) {
      if (a[i] == ' ') a.removeAt(i);
    }
    print(a.length);
    for (var letter in a) {
      setState(() => this.imgpath = letter);
      await Future.delayed(Duration(seconds: 1));
    }
    print(a);
  }
}
