import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okonomi/boxes.dart';
import 'package:okonomi/models/colors.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/models/lists.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({Key? key}) : super(key: key);

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

final _formKey = GlobalKey<FormState>();

class _AddAccountPageState extends State<AddAccountPage> {
  String _currentName = '';
  String _currentOpenAmount = '0.0';
  int _currentCurrency = 0;
  int _currentColor = 0xFFCB576C;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        // App Bar
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(
            'Add Account',
          ),
          backgroundColor: Color(_currentColor),
        ),

        // Save Button
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(_currentColor),
          child: Icon(Icons.save, color: Colors.white),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              addAccount(_currentName, _currentCurrency, _currentColor,
                  double.parse(_currentOpenAmount));
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Incomplete Form"),
              ));
            }
          },
        ),

        // Body
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Account Name
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Name',
                        style: TextStyle(
                            color: Color(_currentColor),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                          decoration: buildInputDecoration(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          onChanged: (val) =>
                              setState(() => _currentName = val)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Opening Balance
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Opening Balance',
                        style: TextStyle(
                            color: Color(_currentColor),
                            fontWeight: FontWeight.w700),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          onChanged: (val) =>
                              setState(() => _currentOpenAmount = val)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Color Selection
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Color Tag',
                        style: TextStyle(
                            color: Color(_currentColor),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 10),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addAccount(
      String name, int currency, int color, double openAmount) async {
    final account = Account()
      ..name = name
      ..currency = currency
      ..color = color
      ..openAmount = openAmount
      ..income = 0.0
      ..expense = 0.0
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
            borderSide: BorderSide(width: 1.5, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: Colors.red)));
  }
}
