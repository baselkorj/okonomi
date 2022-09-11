import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okonomi/models/boxes.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/screens/home/home.dart';

class ManTransaction extends StatefulWidget {
  final currentState;

  ManTransaction({
    this.currentState,
  });

  @override
  _ManTransactionState createState() => _ManTransactionState();
}

GlobalKey<FormState> _transactionForm = GlobalKey<FormState>();

class _ManTransactionState extends State<ManTransaction> {
  int _color = color1;
  var _currentTransaction = ValueNotifier(Transaction());
  bool _updated = false;

  @override
  Widget build(BuildContext context) {
    if (!_updated) {
      if (widget.currentState == 1) {
        _currentTransaction.value.account = currentTransaction.value.account;
        _currentTransaction.value.amount = currentTransaction.value.amount;
        _currentTransaction.value.category = currentTransaction.value.category;
        _currentTransaction.value.dateTime = currentTransaction.value.dateTime;
        _currentTransaction.value.note = currentTransaction.value.note;
        _currentTransaction.value.payee = currentTransaction.value.payee;
        _currentTransaction.value.type = currentTransaction.value.type;
      } else {
        _currentTransaction.value.account = 0;
        _currentTransaction.value.amount = 0.0;
        _currentTransaction.value.category = 'Other';
        _currentTransaction.value.dateTime = DateTime.now();
        _currentTransaction.value.note = '';
        _currentTransaction.value.payee = '';
        _currentTransaction.value.type = 1;
      }
      _updated = true;
    }

    if (_currentTransaction.value.type == 1) {
      _color = color1;
    } else {
      _color = color2;
    }

    double screenWidth = MediaQuery.of(context).size.width;

    return FocusScope(
        child: Form(
            key: _transactionForm,
            child: Scaffold(
              // App Bar
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                title: Text(
                  widget.currentState == 0
                      ? 'Add Transaction'
                      : 'Edit Transaction',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Color(_color),
                actions: [
                  widget.currentState == 0
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    deleteDialog(currentTransaction.value.key));
                          },
                          icon: Icon(Icons.delete, color: Colors.white))
                ],
              ),

              // Save Button
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Color(_color),
                  child: Icon(Icons.save),
                  onPressed: () async {
                    if (_transactionForm.currentState!.validate()) {
                      updateTransaction();
                      updateAccount();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Incomplete Form"),
                      ));
                    }
                  }),
              body: Align(
                alignment: FractionalOffset.topCenter,
                child: Container(
                  width: screenWidth > 550
                      ? 550
                      : MediaQuery.of(context).size.width,
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    children: [
                      // Transaction Type
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transaction Type',
                                style: TextStyle(
                                    color: Color(_color),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  typeBox(
                                      0, color2, Icons.move_to_inbox, 'Income'),
                                  SizedBox(width: 10),
                                  typeBox(1, color1, Icons.outbox, 'Expense'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Amount and Payee
                      Row(children: [
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                        color: Color(_color),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: 10),
                                  Focus(child:
                                      Builder(builder: (BuildContext context) {
                                    final FocusNode focusNode =
                                        Focus.of(context);
                                    final bool hasFocus = focusNode.hasFocus;
                                    return TextFormField(
                                      autofocus: true,
                                      initialValue: widget.currentState == 0
                                          ? ''
                                          : _currentTransaction.value.amount
                                              .toString(),
                                      style: textStyle(hasFocus, _color),
                                      decoration: buildInputDecoration(
                                              hasFocus, _color)
                                          .copyWith(
                                              prefixText:
                                                  '${currentAccount.value.currency}  '),
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
                                      maxLength: 10,
                                      validator: (val) {},
                                      onChanged: (val) => _currentTransaction
                                          .value.amount = double.parse(val),
                                    );
                                  }))
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
                                    _currentTransaction.value.type == 1
                                        ? 'Payer'
                                        : 'Payee',
                                    style: TextStyle(
                                        color: Color(_color),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: 10),
                                  Focus(child:
                                      Builder(builder: (BuildContext context) {
                                    final FocusNode focusNode =
                                        Focus.of(context);
                                    final bool hasFocus = focusNode.hasFocus;
                                    return TextFormField(
                                        initialValue:
                                            _currentTransaction.value.payee,
                                        style: textStyle(hasFocus, _color),
                                        decoration: buildInputDecoration(
                                            hasFocus, _color),
                                        validator: (val) {},
                                        onChanged: (val) => _currentTransaction
                                            .value.payee = val);
                                  }))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),

                      // Category and Date
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
                                      'Category',
                                      style: TextStyle(
                                          color: Color(_color),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: () async {
                                        if (_currentTransaction.value.type ==
                                            1) {
                                          _color = color1;
                                        } else {
                                          _color = color2;
                                        }

                                        double height =
                                            MediaQuery.of(context).size.height;

                                        showDialog<String>(
                                            context: context,
                                            builder:
                                                (BuildContext context) =>
                                                    AlertDialog(
                                                      title: Text(
                                                        'Choose Category',
                                                        style: TextStyle(
                                                            height: 1.5),
                                                      ),
                                                      content: Container(
                                                          height: height * 0.5,
                                                          width: height * 0.3,
                                                          child:
                                                              _currentTransaction
                                                                          .value
                                                                          .type ==
                                                                      1
                                                                  ? ListView
                                                                      .builder(
                                                                      physics:
                                                                          BouncingScrollPhysics(),
                                                                      itemCount:
                                                                          expenseCategories
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return ListTile(
                                                                          title: Text(expenseCategories
                                                                              .keys
                                                                              .toList()[index]),
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0.0,
                                                                              right: 0.0),
                                                                          leading:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                Color(_color),
                                                                            child:
                                                                                Icon(expenseCategories.values.toList()[index], color: Colors.white),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              _currentTransaction.value.category = expenseCategories.keys.toList()[index];
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                        );
                                                                      },
                                                                    )
                                                                  : ListView
                                                                      .builder(
                                                                      physics:
                                                                          BouncingScrollPhysics(),
                                                                      itemCount:
                                                                          incomeCategories
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return ListTile(
                                                                            title:
                                                                                Text(incomeCategories.keys.toList()[index]),
                                                                            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                                                                            leading: CircleAvatar(
                                                                              backgroundColor: Color(_color),
                                                                              child: Icon(incomeCategories.values.toList()[index], color: Colors.white),
                                                                            ),
                                                                            onTap: () {
                                                                              setState(() {
                                                                                _currentTransaction.value.category = incomeCategories.keys.toList()[index];
                                                                              });
                                                                              Navigator.pop(context);
                                                                            });
                                                                      },
                                                                    )),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                            child: Text(
                                                                'Cancel',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary: Color(
                                                                        _color)),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context)),
                                                      ],
                                                    ));
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(_color),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 20),
                                            Icon(
                                              _currentTransaction.value.type ==
                                                      1
                                                  ? expenseCategories[
                                                      _currentTransaction
                                                          .value.category]
                                                  : incomeCategories[
                                                      _currentTransaction
                                                          .value.category],
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              _currentTransaction.value.type ==
                                                      1
                                                  ? '${_currentTransaction.value.category}'
                                                  : '${_currentTransaction.value.category}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        ),
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
                                      'Date',
                                      style: TextStyle(
                                          color: Color(_color),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: () async {
                                        final DateTime? selectedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: _currentTransaction
                                              .value.dateTime,
                                          firstDate: DateTime(0),
                                          lastDate: DateTime.now(),
                                        );
                                        if (selectedDate != null &&
                                            selectedDate !=
                                                _currentTransaction
                                                    .value.dateTime)
                                          setState(() {
                                            _currentTransaction.value.dateTime =
                                                selectedDate;
                                          });
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(_color),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${_currentTransaction.value.dateTime.day} ${months[_currentTransaction.value.dateTime.month - 1]} ${_currentTransaction.value.dateTime.year}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Note
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Note',
                                style: TextStyle(
                                    color: Color(_color),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10),
                              Focus(child:
                                  Builder(builder: (BuildContext context) {
                                final FocusNode focusNode = Focus.of(context);
                                final bool hasFocus = focusNode.hasFocus;
                                return TextFormField(
                                    initialValue:
                                        _currentTransaction.value.note,
                                    style: textStyle(hasFocus, _color),
                                    decoration:
                                        buildInputDecoration(hasFocus, _color),
                                    validator: (val) {},
                                    onChanged: (val) => setState(() =>
                                        _currentTransaction.value.note = val));
                              }))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  Expanded typeBox(int type, int color, IconData icon, String name) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentTransaction.value.type = type;
            _currentTransaction.value.category = 'Other';
          });
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: type == 0
                  ? _currentTransaction.value.type == 0
                      ? Color(color)
                      : Color(color10)
                  : _currentTransaction.value.type == 1
                      ? Color(color)
                      : Color(color10),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                icon,
                color: Colors.white,
                size: 45,
              ),
              SizedBox(width: 10),
              Text(
                '$name',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future updateTransaction() async {
    final transaction = Transaction()
      ..payee = _currentTransaction.value.payee
      ..account = currentAccount.value.key
      ..category = _currentTransaction.value.category
      ..note = _currentTransaction.value.note
      ..type = _currentTransaction.value.type
      ..amount = _currentTransaction.value.amount
      ..dateTime = _currentTransaction.value.dateTime;

    final box = Boxes.getTransactions();

    widget.currentState == 0
        ? box.add(transaction)
        : box.putAt(currentTransaction.value.key, transaction);
  }

  Future updateAccount() async {
    if (widget.currentState == 1) {
      if (currentTransaction.value.type == 1) {
        currentAccount.value.expenses -= currentTransaction.value.amount;
      } else {
        currentAccount.value.income -= currentTransaction.value.amount;
      }
    }

    if (_currentTransaction.value.type == 1) {
      currentAccount.value.expenses += _currentTransaction.value.amount;
    } else {
      currentAccount.value.income += _currentTransaction.value.amount;
    }

    final account = Account()
      ..name = currentAccount.value.name
      ..currency = currentAccount.value.currency
      ..color = currentAccount.value.color
      ..openAmount = currentAccount.value.openAmount
      ..income = currentAccount.value.income
      ..expenses = currentAccount.value.expenses
      ..goalLimit = currentAccount.value.goalLimit;

    final box = Boxes.getAccounts();
    box.putAt(currentAccount.value.key, account);
  }

  AlertDialog deleteDialog(int key) {
    return AlertDialog(
      title: Text(
        'Caution!',
        style: TextStyle(height: 1.5, color: Color(color1)),
      ),
      content: Text(
        "Are you sure you want to delete this transaction?",
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Color(color8)),
            )),
        ElevatedButton(
            child: Text('Delete', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(primary: Color(color1)),
            onPressed: () async {
              Navigator.pop(context);
              await deleteTransaction(key);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }),
      ],
    );
  }

  Future deleteTransaction(int key) async {
    final box = Boxes.getTransactions();
    box.delete(key);
  }
}
