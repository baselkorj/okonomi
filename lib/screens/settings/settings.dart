import 'package:flutter/material.dart';
import 'package:okonomi/models/style.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Settings'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(color1),
        child: Icon(Icons.save),
        onPressed: () {},
      ),
    );
  }
}
