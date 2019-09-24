import 'package:ml_vision/ml/facePage.dart';
import 'package:ml_vision/ml/labelerPage.dart';
import 'package:ml_vision/ml/landmarkPage.dart';
import 'package:ml_vision/ml/languagePage.dart';
import 'package:ml_vision/ml/replyPage.dart';
import 'package:ml_vision/ml/textPage.dart';
import 'package:ml_vision/ml/translatePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        title: 'Flutter ML Vision',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => ChoicesPage(),
          '/text': (context) => TextPage(),
          '/face': (context) => FacePage(),
          '/labeler': (context) => LabelerPage(),
          '/language': (context) => LanguagePage(),
          '/landmark': (context) => LandmarkPage(),
          '/translate': (context) =>TranslatePage(),
          '/reply': (context) => ReplyPage(),
        },
      ),
    );

class ChoicesPage extends StatefulWidget {
  @override
  _ChoicesPageState createState() => _ChoicesPageState();
}

class _ChoicesPageState extends State<ChoicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recognition Types"),
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            title: Text("Text Recognition"),
            subtitle: Text("Recognize text in any Latin-based language"),
            leading: Icon(Icons.text_fields),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/text');
            },
          ),
          ListTile(
            title: Text("Face Recognition"),
            subtitle: Text("Detect faces in an image"),
            leading: Icon(Icons.face),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/face');
            },
          ),
          ListTile(
            title: Text("Image Labeler"),
            subtitle: Text("Recognize entities in an image"),
            leading: Icon(Icons.extension),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/labeler');
            },
          ),
          ListTile(
            title: Text("Language Identifiction"),
            subtitle: Text("Identifiy language of text"),
            leading: Icon(Icons.language),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/language');
            },
          ),
          ListTile(
            title: Text("Landmark Recognition"),
            subtitle: Text("Determine well-known landmarks in an image"),
            leading: Icon(Icons.landscape),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/landmark');
            },
          ),
          ListTile(
            title: Text("Translations"),
            subtitle: Text("Translate text between 59 languages"),
            leading: Icon(Icons.g_translate),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/translate');
            },
          ),
          ListTile(
            title: Text("Smart Reply"),
            subtitle: Text("Generate relevant replies to messages"),
            leading: Icon(Icons.reply),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/reply');
            },
          ),
        ]).toList(),
      ),
    );
  }
}
