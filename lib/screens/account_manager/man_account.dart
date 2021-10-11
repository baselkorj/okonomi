import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okonomi/boxes.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/screens/account_manager/account_global.dart' as global;
import 'package:okonomi/screens/account_manager/currency_chooser.dart';
import 'package:okonomi/screens/home.dart';

class ManAccount extends StatefulWidget {
  final currentKey;
  final currentState;
  final isUrgent;

  ManAccount({this.currentKey, this.currentState, this.isUrgent});

  @override
  _ManAccountState createState() => _ManAccountState();
}

GlobalKey<FormState> _accountForm = GlobalKey<FormState>();

class _ManAccountState extends State<ManAccount> {
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Form(
        key: _accountForm,
        child: Scaffold(
          // App Bar
          appBar: AppBar(
            brightness: Brightness.dark,
            title: Text(
              widget.currentState == 0 ? 'Add Account' : 'Edit Account',
            ),
            backgroundColor: Color(global.currentColor),
            actions: [
              widget.currentState == 0
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                deleteDialog(widget.currentKey));
                      },
                      icon: Icon(Icons.delete, color: Colors.white))
            ],
          ),

          // Save Button
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(global.currentColor),
            child: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              if (_accountForm.currentState!.validate()) {
                widget.currentState == 0
                    ? addAccount(
                        global.currentName,
                        global.currentCurrency.value,
                        global.currentColor,
                        double.parse(global.currentOpenAmount),
                        double.parse(global.currentGoalLimit))
                    : editAccount(
                        global.currentName,
                        global.currentCurrency.value,
                        global.currentColor,
                        double.parse(global.currentOpenAmount),
                        double.parse(global.currentGoalLimit));
                if (widget.isUrgent != true) {
                  Navigator.pop(context);
                }
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
                              color: Color(global.currentColor),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10),
                        Focus(child: Builder(builder: (BuildContext context) {
                          final FocusNode focusNode = Focus.of(context);
                          final bool hasFocus = focusNode.hasFocus;
                          return TextFormField(
                              initialValue: global.currentName,
                              style: textStyle(hasFocus, global.currentColor),
                              decoration: buildInputDecoration(
                                  hasFocus, global.currentColor),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              onChanged: (val) => global.currentName = val);
                        }))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),

                // Opening and Goal Balance
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Opening Balance',
                                style: TextStyle(
                                    color: Color(global.currentColor),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10),
                              Focus(
                                child: Builder(
                                  builder: (BuildContext context) {
                                    final FocusNode focusNode =
                                        Focus.of(context);
                                    final bool hasFocus = focusNode.hasFocus;
                                    return TextFormField(
                                        initialValue: widget.currentState == 0
                                            ? ''
                                            : global.currentOpenAmount,
                                        style: textStyle(
                                            hasFocus, global.currentColor),
                                        decoration: buildInputDecoration(
                                                hasFocus, global.currentColor)
                                            .copyWith(
                                          hintText: '0.0',
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r"[0-9.]")),
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            try {
                                              final text = newValue.text;
                                              if (text.isNotEmpty)
                                                double.parse(text);
                                              return newValue;
                                            } catch (e) {}
                                            return oldValue;
                                          }),
                                        ],
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                          decimal: true,
                                          signed: false,
                                        ),
                                        maxLength: 16,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        onChanged: (val) =>
                                            global.currentOpenAmount = val);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Goal / Limit',
                                style: TextStyle(
                                    color: Color(global.currentColor),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10),
                              Focus(
                                child: Builder(
                                  builder: (BuildContext context) {
                                    final FocusNode focusNode =
                                        Focus.of(context);
                                    final bool hasFocus = focusNode.hasFocus;
                                    return TextFormField(
                                        initialValue: widget.currentState == 0
                                            ? ''
                                            : global.currentGoalLimit,
                                        style: textStyle(
                                            hasFocus, global.currentColor),
                                        decoration: buildInputDecoration(
                                                hasFocus, global.currentColor)
                                            .copyWith(
                                          hintText: '0.0',
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r"[0-9.]")),
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            try {
                                              final text = newValue.text;
                                              if (text.isNotEmpty)
                                                double.parse(text);
                                              return newValue;
                                            } catch (e) {}
                                            return oldValue;
                                          }),
                                        ],
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                          decimal: true,
                                          signed: false,
                                        ),
                                        maxLength: 16,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        onChanged: (val) =>
                                            global.currentGoalLimit = val);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Currency Chooser
                Card(
                    child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose Currency',
                        style: TextStyle(
                            color: Color(global.currentColor),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 10),
                      Card(
                        child: ValueListenableBuilder(
                          valueListenable: global.currentCurrency,
                          builder: (context, value, _) {
                            return ListTile(
                              title: Text(
                                  '${currenciesSymbolic[global.currentCurrency.value][0]}'),
                              subtitle: Text('${global.currentCurrency.value}'),
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  '${currenciesSymbolic[global.currentCurrency.value][1]}',
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                              trailing: Icon(Icons.edit,
                                  color: Color(global.currentColor)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CurrencyChooser()));
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),

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
                              color: Color(global.currentColor),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Red
                            colorPallete(0xFFCB576C),

                            // Blue
                            colorPallete(0xFF4781BE),

                            // Yellow
                            colorPallete(0xFFEDA924),

                            // Green
                            colorPallete(0xFF8BBC25),

                            // Orange
                            colorPallete(0xFFFFA057),

                            // Cyan
                            colorPallete(0xFF57CBB6),

                            // Indigo
                            colorPallete(0xFF595DA6),
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
      ),
    );
  }

  AlertDialog deleteDialog(int key) {
    return AlertDialog(
      title: Text(
        'Caution!',
        style: TextStyle(height: 1.5),
      ),
      content: Text(
        "Are you sure you want to delete this account? You won't be able to recover any data under it.",
        style: TextStyle(color: Colors.black45),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black54),
            )),
        ElevatedButton(
            child: Text('Delete', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(primary: Color(color1)),
            onPressed: () async {
              Navigator.pop(context);
              await deleteAccount(key);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }),
      ],
    );
  }

  InkWell colorPallete(int color) {
    return InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          setState(() {
            global.currentColor = color;
          });
        },
        child: CircleAvatar(
            backgroundColor: Color(color),
            radius: 18,
            child: global.currentColor == color
                ? Icon(Icons.check, size: 28, color: Colors.white)
                : Container()));
  }

  Future addAccount(String name, String currency, int color, double openAmount,
      double goalLimit) async {
    final account = Account()
      ..name = name
      ..currency = currency
      ..color = color
      ..openAmount = openAmount
      ..income = 0.0
      ..expenses = 0.0
      ..goalLimit = goalLimit;

    final box = Boxes.getAccounts();
    box.add(account);
  }

  Future editAccount(String name, String currency, int color, double openAmount,
      double goalLimit) async {
    final account = Account()
      ..name = name
      ..currency = currency
      ..color = color
      ..openAmount = openAmount
      ..income = 0.0
      ..expenses = 0.0
      ..goalLimit = goalLimit;

    final box = Boxes.getAccounts();
    box.putAt(widget.currentKey, account);
  }

  Future deleteAccount(int key) async {
    final box = Boxes.getAccounts();
    box.delete(key);
  }
}
