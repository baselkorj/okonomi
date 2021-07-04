import 'package:flutter/material.dart';
import 'package:okonomi/models/colors.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Accounts',
        ),
        backgroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Add Account',
                      style: TextStyle(height: 1.5),
                    ),
                    content: Text(
                      "Are you sure you want to delete this account? You won't be able to recover any data under it.",
                      style: TextStyle(color: Colors.black45),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel')),
                      ElevatedButton(
                          child: Text('Save',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(primary: color1),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ));
        },
        label: Text('Account'),
        icon: Icon(Icons.add),
        backgroundColor: color1,
        elevation: 4,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
            horizontal: height * 0.01, vertical: height * 0.01),
        children: <Widget>[
          Card(
            child: ListTile(
              leading: CircleAvatar(backgroundColor: color1),
              title: Text('Personal'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                InkWell(
                  onTap: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'Edit Account',
                                style: TextStyle(height: 1.5),
                              ),
                              content: Text(
                                "Are you sure you want to delete this account? You won't be able to recover any data under it.",
                                style: TextStyle(color: Colors.black45),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel')),
                                ElevatedButton(
                                    child: Text('Save',
                                        style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                        primary: color2),
                                    onPressed: () => Navigator.pop(context)),
                              ],
                            ));
                  },
                  child: Container(
                      padding: EdgeInsets.all(height * 0.005),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * 0.005)),
                          color: color2),
                      child: Icon(Icons.edit, color: Colors.white)),
                ),
                SizedBox(width: height * 0.015),
                InkWell(
                  onTap: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'Delete Account?',
                                style: TextStyle(height: 1.5),
                              ),
                              content: Text(
                                "Are you sure you want to delete this account? You won't be able to recover any data under it.",
                                style: TextStyle(color: Colors.black45),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel')),
                                ElevatedButton(
                                    child: Text('Delete',
                                        style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                        primary: color1),
                                    onPressed: () => Navigator.pop(context)),
                              ],
                            ));
                  },
                  child: Container(
                      padding: EdgeInsets.all(height * 0.005),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * 0.005)),
                          color: color1),
                      child: Icon(Icons.delete, color: Colors.white)),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
