import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okonomi/boxes.dart';
import 'package:okonomi/models/colors.dart';
import 'package:okonomi/models/db.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

final _formKey = GlobalKey<FormState>();

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Scaffold(
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
                builder: (BuildContext context) {
                  String _currentName = '';
                  String _currentOpenAmount = '';
                  String _currentCurrency = '';
                  int _currentColor = 0xFFCB576C;
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: Text(
                          'Add Account',
                          style: TextStyle(height: 1.5),
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Account Name',
                              style: TextStyle(
                                  color: color1, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                                decoration: buildInputDecoration(),
                                maxLength: 6,
                                validator: (val) {},
                                onChanged: (val) =>
                                    setState(() => _currentName = val)),
                            SizedBox(height: height * 0.015),
                            Text(
                              'Amount',
                              style: TextStyle(
                                  color: color1, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                                decoration: buildInputDecoration(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9.]")),
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    try {
                                      final text = newValue.text;
                                      if (text.isNotEmpty) double.parse(text);
                                      return newValue;
                                    } catch (e) {}
                                    return oldValue;
                                  }),
                                ],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                  signed: false,
                                ),
                                maxLength: 6,
                                validator: (val) {},
                                onChanged: (val) =>
                                    setState(() => _currentOpenAmount = val)),
                            SizedBox(height: height * 0.015),
                            Text(
                              'Color Tag',
                              style: TextStyle(
                                  color: color1, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Red
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentColor = 0xFFCB576C;
                                      });
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: Color(0xFFCB576C),
                                        radius: 18,
                                        child: _currentColor == 0xFFCB576C
                                            ? Icon(Icons.check,
                                                size: 28, color: Colors.white)
                                            : Container())),

                                // Blue
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentColor = 0xFF4781BE;
                                      });
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: Color(0xFF4781BE),
                                        radius: 18,
                                        child: _currentColor == 0xFF4781BE
                                            ? Icon(Icons.check,
                                                size: 28, color: Colors.white)
                                            : Container())),

                                // Yellow
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentColor = 0xFFEDA924;
                                      });
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: Color(0xFFEDA924),
                                        radius: 18,
                                        child: _currentColor == 0xFFEDA924
                                            ? Icon(Icons.check,
                                                size: 28, color: Colors.white)
                                            : Container())),

                                // Green
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentColor = 0xFF8BBC25;
                                      });
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: Color(0xFF8BBC25),
                                        radius: 18,
                                        child: _currentColor == 0xFF8BBC25
                                            ? Icon(Icons.check,
                                                size: 28, color: Colors.white)
                                            : Container())),

                                // Orange
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentColor = 0xFFFFA057;
                                      });
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: Color(0xFFFFA057),
                                        radius: 18,
                                        child: _currentColor == 0xFFFFA057
                                            ? Icon(Icons.check,
                                                size: 28, color: Colors.white)
                                            : Container())),
                              ],
                            )
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel')),
                          ElevatedButton(
                            child: Text('Save',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(primary: color1),
                            onPressed: () {
                              addAccount(_currentName, _currentCurrency,
                                  _currentColor, int.parse(_currentOpenAmount));
                            },
                          )
                        ],
                      );
                    },
                  );
                });
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
                                          style:
                                              TextStyle(color: Colors.white)),
                                      style: ElevatedButton.styleFrom(
                                          primary: color2),
                                      onPressed: () => Navigator.pop(context)),
                                ],
                              ));
                    },
                    child: Container(
                        padding: EdgeInsets.all(height * 0.005),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(height * 0.005)),
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
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel')),
                                  ElevatedButton(
                                      child: Text('Delete',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      style: ElevatedButton.styleFrom(
                                          primary: color1),
                                      onPressed: () => Navigator.pop(context)),
                                ],
                              ));
                    },
                    child: Container(
                        padding: EdgeInsets.all(height * 0.005),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(height * 0.005)),
                            color: color1),
                        child: Icon(Icons.delete, color: Colors.white)),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future addAccount(
      String name, String currency, int color, int openAmount) async {
    final account = Account()
      ..name = name
      ..currency = currency
      ..color = color
      ..openAmount = openAmount
      ..income = 0
      ..expense = 0
      ..total = openAmount;

    final box = Boxes.getAccounts();
    box.add(account);
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
        errorStyle: TextStyle(height: 0),
        counterText: '',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1.5)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(width: 2, color: color1)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red)));
  }
}
