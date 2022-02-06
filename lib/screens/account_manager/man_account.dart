import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okonomi/boxes.dart';
import 'package:okonomi/main.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/screens/account_manager/currency_chooser.dart';

class ManAccount extends StatefulWidget {
  final currentState;
  final isUrgent;

  ManAccount({this.currentState, this.isUrgent});

  @override
  _ManAccountState createState() => _ManAccountState();
}

GlobalKey<FormState> _accountForm = GlobalKey<FormState>();

class _ManAccountState extends State<ManAccount> {
  var _currentAccount = ValueNotifier(Account());
  var _currentColor = 0xFFCB576C;
  bool _updated = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (!_updated) {
      if (widget.currentState == 0) {
        _currentAccount.value.name = '';
        _currentAccount.value.currency = 'AED';
        _currentAccount.value.color = _currentColor;
        _currentAccount.value.openAmount = 0.0;
        _currentAccount.value.income = 0.0;
        _currentAccount.value.expenses = 0.0;
        _currentAccount.value.goalLimit = 0.0;
      } else {
        _currentAccount = currentAccount;
        _currentColor = _currentAccount.value.color;
      }
      _updated = true;
    }

    return FocusScope(
      child: Form(
        key: _accountForm,
        child: Scaffold(
          // App Bar
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            title: Text(
              widget.currentState == 0 ? 'Add Account' : 'Edit Account',
            ),
            backgroundColor: Color(_currentColor),
            actions: [
              widget.currentState == 0
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                deleteDialog(_currentAccount.value.key));
                      },
                      icon: Icon(Icons.delete, color: Colors.white))
            ],
          ),

          // Save Button
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(_currentColor),
            child: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              if (_accountForm.currentState!.validate()) {
                widget.currentState == 0
                    ? addAccount(
                        _currentAccount.value.name,
                        _currentAccount.value.currency,
                        _currentColor,
                        _currentAccount.value.openAmount,
                        _currentAccount.value.goalLimit)
                    : editAccount(
                        _currentAccount.value.name,
                        _currentAccount.value.currency,
                        _currentColor,
                        _currentAccount.value.openAmount,
                        _currentAccount.value.goalLimit);
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
          body: Align(
            alignment: FractionalOffset.topCenter,
            child: Container(
              width:
                  screenWidth > 550 ? 550 : MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
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
                            Focus(
                                child: Builder(builder: (BuildContext context) {
                              final FocusNode focusNode = Focus.of(context);
                              final bool hasFocus = focusNode.hasFocus;
                              return TextFormField(
                                  initialValue: _currentAccount.value.name,
                                  style: textStyle(hasFocus, _currentColor),
                                  decoration: buildInputDecoration(
                                      hasFocus, _currentColor),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) =>
                                      _currentAccount.value.name = value);
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
                                        color: Color(_currentColor),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: 10),
                                  Focus(
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        final FocusNode focusNode =
                                            Focus.of(context);
                                        final bool hasFocus =
                                            focusNode.hasFocus;
                                        return TextFormField(
                                            initialValue:
                                                widget.currentState == 0
                                                    ? ''
                                                    : _currentAccount
                                                        .value.openAmount
                                                        .toString(),
                                            style: textStyle(
                                                hasFocus, _currentColor),
                                            decoration: buildInputDecoration(
                                                    hasFocus, _currentColor)
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
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return '';
                                              }
                                              return null;
                                            },
                                            onChanged: (val) => _currentAccount
                                                    .value.openAmount =
                                                double.parse(val));
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
                                        color: Color(_currentColor),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: 10),
                                  Focus(
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        final FocusNode focusNode =
                                            Focus.of(context);
                                        final bool hasFocus =
                                            focusNode.hasFocus;
                                        return TextFormField(
                                            initialValue:
                                                widget.currentState == 0
                                                    ? ''
                                                    : _currentAccount
                                                        .value.goalLimit
                                                        .toString(),
                                            style: textStyle(
                                                hasFocus, _currentColor),
                                            decoration: buildInputDecoration(
                                                    hasFocus, _currentColor)
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
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return '';
                                              }
                                              return null;
                                            },
                                            onChanged: (val) => _currentAccount
                                                .value
                                                .goalLimit = double.parse(val));
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
                                color: Color(_currentColor),
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          Card(
                            child: ValueListenableBuilder(
                              valueListenable: currentCurrency,
                              builder: (context, value, _) {
                                _currentAccount.value.currency =
                                    currentCurrency.value;

                                return ListTile(
                                  title: Text(
                                      '${currenciesSymbolic[_currentAccount.value.currency][0]}'),
                                  subtitle:
                                      Text('${_currentAccount.value.currency}'),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Text(
                                      '${currenciesSymbolic[_currentAccount.value.currency][1]}',
                                      style: TextStyle(fontSize: 32),
                                    ),
                                  ),
                                  trailing: Icon(Icons.edit,
                                      color: Color(_currentColor)),
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
                                  color: Color(_currentColor),
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
            }),
      ],
    );
  }

  InkWell colorPallete(int color) {
    return InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          setState(() {
            _currentColor = color;
          });
        },
        child: CircleAvatar(
            backgroundColor: Color(color),
            radius: 18,
            child: _currentColor == color
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
    box.putAt(_currentAccount.value.key, account);
  }

  Future deleteAccount(int key) async {
    final accounts = Boxes.getAccounts();

    final transactions = Boxes.getTransactions()
        .values
        .where((transaction) => transaction.account == key)
        .toList();

    // Delete All Transactions Under the Account
    for (var i = 0; i < transactions.length; i++) {
      Boxes.getTransactions().delete(transactions[i].key);
    }

    // Delete the Account
    accounts.delete(key);

    RestartWidget.restartApp(context);
  }
}
