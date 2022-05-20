import 'package:flutter/material.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/models/style.dart';
import 'dart:js' as js;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text('Settings'),
        ),
        body: Align(
            alignment: FractionalOffset.topCenter,
            child: Container(
                width:
                    screenWidth > 550 ? 550 : MediaQuery.of(context).size.width,
                child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    children: [
                      // Look & Feel
                      Text(
                        ' Look & Feel',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.grey),
                      ),
                      SizedBox(height: 5),

                      // Dark Mode
                      Card(
                        child: ListTile(
                            title: Text('Enable Dark Mode'),
                            leading: Icon(Icons.dark_mode),
                            trailing: Switch(
                              activeColor: Color(color1),
                              onChanged: (bool value) => setState(() {
                                isDark.value = !isDark.value;
                              }),
                              value: isDark.value,
                            )),
                      ),
                      SizedBox(height: 25),

                      // Development
                      Text(
                        ' Development',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.grey),
                      ),
                      SizedBox(height: 5),

                      // View Source Code
                      Card(
                        child: ListTile(
                          title: Text('Report a Bug'),
                          leading: Icon(Icons.bug_report),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Request a Feature'),
                          leading: Icon(Icons.settings_applications),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          onTap: () => js.context.callMethod(
                              'open', ['https://github.com/baselkorj/okonomi']),
                          child: ListTile(
                            title: Text('View Source Code on Github'),
                            subtitle:
                                Text('https://github.com/baselkorj/okonomi'),
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.people),
                              ],
                            ),
                            trailing: Icon(Icons.exit_to_app),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                    ]))));
  }
}
