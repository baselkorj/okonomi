import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:okonomi/boxes.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/screens/account_manager/add_account.dart';
import 'package:okonomi/screens/transaction.dart';
import 'package:okonomi/screens/account_manager/account_global.dart' as global;
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  var _selected = 0;
  bool _updated = false;

  Map _currentDayMap = {};

  int _currentMonth = 10;

  @override
  Widget build(BuildContext context) {
    // Safety Net: Reset Global Values
    global.currentName = '';
    global.currentOpenAmount = '0.0';
    global.currentColor = 0xFFCB576C;
    global.currentCurrency.value = 'AFN';

    double _income = 0;
    double _expense = 0;
    double _total = 0;

    int isExpense(double amount) {
      _total = _total - amount;
      _expense = _expense + amount;
      return 0;
    }

    int isIncome(double amount) {
      _total = _total + amount;
      _income = _income + amount;
      return 0;
    }

    return ValueListenableBuilder<Box<Account>>(
        valueListenable: Boxes.getAccounts().listenable(),
        builder: (context, box, _) {
          final accounts = box.values.toList().cast<Account>();

          if (accounts.isEmpty) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddAccountPage()));
          }

          // Select First Account
          if (_updated == false) {
            _selected = accounts[0].key;
            _updated = true;
          }

          // Update Income, Expense, and Total
          _income = accounts[_selected].income;
          _expense = accounts[_selected].expenses;

          final mybox = Boxes.getAccounts();
          final _currentAccount = mybox.get(_selected);

          return Scaffold(
            // App Bar
            appBar: AppBar(
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: Colors.black87),
              title: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_currentAccount!.name}',
                      style: TextStyle(color: Color(_currentAccount.color)),
                    ),
                    SizedBox(height: 1),
                    Text(
                      "Aug 2021",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    )
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
                IconButton(onPressed: () {}, icon: Icon(Icons.event)),
              ],
            ),

            drawer: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (Padding(
                    padding: EdgeInsets.fromLTRB(30, 75, 0, 0),
                    child: Text('Accounts',
                        style: TextStyle(
                            color: Color(_currentAccount.color), fontSize: 32)),
                  )),
                  Container(
                    child: Expanded(
                      child: accounts.isEmpty
                          ? NoAccounts()
                          : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: accounts.length,
                              itemBuilder: (BuildContext context, int index) {
                                final account = accounts[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    onTap: () {
                                      setState(() {
                                        _selected = accounts[index].key;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color:
                                              accounts[index].key == _selected
                                                  ? Color(accounts[index].color)
                                                      .withAlpha(55)
                                                  : Colors.transparent),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              child: Text(
                                                '${account.name}',
                                                style: TextStyle(
                                                  color: Color(
                                                      accounts[index].color),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            leading: CircleAvatar(
                                                backgroundColor:
                                                    Color(account.color)),
                                            trailing: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: _selected == index
                                                    ? Icon(
                                                        Icons.edit,
                                                        color: Color(
                                                            account.color),
                                                      )
                                                    : Container(
                                                        height: 0,
                                                        width: 0,
                                                      ),
                                              ),
                                              onTap: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    ),
                  ),
                  Container(
                      child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                              child: Column(
                            children: <Widget>[
                              Divider(),
                              ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddAccountPage()));
                                  },
                                  leading: Icon(Icons.add_circle, size: 32),
                                  title: Text('Add an Account')),
                              ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddAccountPage()));
                                  },
                                  leading: Icon(Icons.settings, size: 32),
                                  title: Text('Settings')),
                            ],
                          )))),
                ],
              ),
            ),

            // Export Button
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'export',
                  onPressed: () {},
                  label: Text('Export'),
                  icon: Icon(Icons.print),
                  backgroundColor: Color(color1),
                  elevation: 4,
                ),
                SizedBox(height: 10),
                FloatingActionButton.extended(
                  heroTag: 'add_transaction',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTransaction(
                                  currentKey: _currentAccount.key,
                                  currentCurrency: _currentAccount.currency,
                                )));
                  },
                  label: Text('Transaction'),
                  icon: Icon(Icons.add),
                  backgroundColor: Color(color4),
                  elevation: 4,
                ),
              ],
            ),

            // Body
            body: ValueListenableBuilder<Box<Transaction>>(
                valueListenable: Boxes.getTransactions().listenable(),
                builder: (context, box, _) {
                  final transactions = box.values
                      .where((transaction) =>
                          transaction.account == _currentAccount.key)
                      .where((transaction) =>
                          transaction.dateTime.month == _currentMonth)
                      .toList();

                  if (transactions.isNotEmpty) {
                    // Calculate Transactions
                    for (int i = 0; i < transactions.length; i++) {
                      transactions[i].type == 1
                          ? isExpense(transactions[i].amount)
                          : isIncome(transactions[i].amount);
                    }

                    // Create Day Map
                    _currentDayMap.clear();

                    for (int m = 31; m >= 0; m--) {
                      final dailyTransactions = transactions
                          .where((transaction) => transaction.dateTime.day == m)
                          .toList();

                      if (dailyTransactions.isNotEmpty) {
                        _currentDayMap.putIfAbsent(m, () => dailyTransactions);
                      }
                    }

                    return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(children: [
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Income
                                  countTile('Income', _income, color2),
                                  SizedBox(width: 10),

                                  // Expense
                                  countTile('Expense', _expense, color1),
                                  SizedBox(width: 10),

                                  // Total
                                  countTile('Total', _total, color3),
                                ],
                              ),
                              SizedBox(height: 15),

                              // Transactions List
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _currentDayMap.keys.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var _thisDay =
                                      _currentDayMap.keys.toList()[index];

                                  return Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            '${months[_currentMonth - 1]} $_thisDay',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54)),
                                                        Text(
                                                            '${dateIndent(_thisDay)}',
                                                            style: TextStyle(
                                                                fontSize: 8,
                                                                color: Colors
                                                                    .black54)),
                                                        Text(
                                                            ' | ${DateFormat('E').format(_currentDayMap[_thisDay][0].dateTime)}',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54)),
                                                      ],
                                                    ),
                                                    Text('Total: 15325',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .black54)),
                                                  ],
                                                )),
                                            Divider(
                                              color: Colors.black26,
                                              height: 5,
                                            ),
                                            ListView.builder(
                                                itemCount:
                                                    _currentDayMap[_thisDay]
                                                        .length,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var _currentAccess =
                                                      _currentDayMap[_thisDay]
                                                          .toList()[index];

                                                  return ListTile(
                                                    title: Text(
                                                        '${_currentAccess.category}'),
                                                    subtitle: Text(
                                                        '${_currentAccess.note}'),
                                                    leading: _currentAccess
                                                                .type ==
                                                            1
                                                        ? CircleAvatar(
                                                            backgroundColor:
                                                                Color(color1),
                                                            child: Icon(
                                                                expenseCategories[
                                                                    _currentAccess
                                                                        .category],
                                                                color: Colors
                                                                    .white))
                                                        : CircleAvatar(
                                                            backgroundColor:
                                                                Color(color2),
                                                            child: Icon(
                                                                incomeCategories[
                                                                    _currentAccess
                                                                        .category],
                                                                color: Colors
                                                                    .white)),
                                                    trailing: _currentAccess
                                                                .type ==
                                                            1
                                                        ? Text(
                                                            '-${_currentAccess.amount}',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    color1)))
                                                        : Text(
                                                            '+${_currentAccess.amount}',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    color2))),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10)
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: 125),
                            ])));
                  } else {
                    return NoAccounts();
                  }
                }),
          );
        });
  }

  Expanded countTile(String title, double amount, int color) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(color)),
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 15),
                Text(
                  '$amount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 10)
              ],
            )));
  }

  String dateIndent(int day) {
    if (day == 1) {
      return 'st';
    } else if (day == 2) {
      return 'nd';
    } else if (day == 3) {
      return 'rd';
    } else {
      return 'th';
    }
  }
}

class NoAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: (Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.black45,
          ),
          SizedBox(height: 15),
          Text(
            'No accounts found.',
            style: TextStyle(color: Colors.black45),
          ),
          Text('Add an account to get started.',
              style: TextStyle(color: Colors.black45))
        ],
      )),
    );
  }
}
