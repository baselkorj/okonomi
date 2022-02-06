import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:okonomi/boxes.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/screens/account_manager/man_account.dart';
import 'package:okonomi/screens/export.dart';
import 'package:okonomi/screens/home/widgets/countTile.dart';
import 'package:okonomi/screens/home/widgets/dateDialog.dart';
import 'package:okonomi/screens/man_transaction.dart';
import 'package:okonomi/models/global.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  final accounts;
  Home({this.accounts});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  int _selected = 0;
  bool _updated = false;
  int _key = 0;

  Map _currentDayMap = {};

  int _currentMonth = currentDate.value[0];
  int _currentYear = currentDate.value[1];

  @override
  Widget build(BuildContext context) {
    double _income = 0;
    double _expense = 0;
    double _total = 0;

    int isExpense(double amount) {
      _total -= amount;
      _expense += amount;
      return 0;
    }

    int isIncome(double amount) {
      _total += amount;
      _income += amount;
      return 0;
    }

    double screenWidth = MediaQuery.of(context).size.width;

    return ValueListenableBuilder<Box<Account>>(
        valueListenable: Boxes.getAccounts().listenable(),
        builder: (context, box, _) {
          final accounts = box.values.toList().cast<Account>();

          if (accounts.isEmpty) {
            return ManAccount(currentState: 0, isUrgent: true);
          } else {
            // Select First Account
            if (_updated == false) {
              _selected = 0;
              _key = accounts[_selected].key;
              _updated = true;
            }

            final mybox = Boxes.getAccounts();
            currentAccount = ValueNotifier(mybox.get(_key)!);

            return ValueListenableBuilder(
                valueListenable: currentDate,
                builder: (context, value, _) {
                  _currentMonth = currentDate.value[0];
                  _currentYear = currentDate.value[1];

                  return Scaffold(
                    // App Bar
                    appBar: AppBar(
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                      iconTheme: IconThemeData(color: Colors.black87),
                      title: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${currentAccount.value.name}',
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                  color: Color(currentAccount.value.color)),
                            ),
                            SizedBox(height: 1),
                            Text(
                              '${months[_currentMonth]} ' '$_currentYear',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                      actions: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DateDialog(
                                    month: _currentMonth,
                                    year: _currentYear,
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.event)),
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
                                    color: Color(currentAccount.value.color),
                                    fontSize: 32)),
                          )),
                          Container(
                            child: Expanded(
                              child: accounts.isEmpty
                                  ? NoAccounts()
                                  : ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: accounts.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final account = accounts[index];

                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: InkWell(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            onTap: () {
                                              setState(() {
                                                _selected = index;
                                                _key = accounts[_selected].key;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: accounts[index].key ==
                                                          _key
                                                      ? Color(accounts[index]
                                                              .color)
                                                          .withAlpha(55)
                                                      : Colors.transparent),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        '${account.name}',
                                                        overflow:
                                                            TextOverflow.fade,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                          color: Color(
                                                              accounts[index]
                                                                  .color),
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    leading: CircleAvatar(
                                                        backgroundColor: Color(
                                                            account.color)),
                                                    trailing: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child:
                                                            _selected == index
                                                                ? Icon(
                                                                    Icons.edit,
                                                                    color: Color(
                                                                        account
                                                                            .color),
                                                                  )
                                                                : Container(
                                                                    height: 0,
                                                                    width: 0,
                                                                  ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ManAccount(
                                                                        currentState:
                                                                            1)));
                                                      },
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
                                                        ManAccount(
                                                            currentState: 0)));
                                          },
                                          leading:
                                              Icon(Icons.add_circle, size: 32),
                                          title: Text('Add an Account')),
                                      ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ManAccount()));
                                          },
                                          leading:
                                              Icon(Icons.settings, size: 32),
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExportPage(
                                          currentAccount: currentAccount,
                                        )));
                          },
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
                                    builder: (context) =>
                                        ManTransaction(currentState: 0)));
                          },
                          label: Text('Transaction'),
                          icon: Icon(Icons.add),
                          backgroundColor: Color(color4),
                          elevation: 4,
                        ),
                      ],
                    ),

                    // Body
                    body: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: screenWidth > 550
                            ? 550
                            : MediaQuery.of(context).size.width,
                        child: ValueListenableBuilder<Box<Transaction>>(
                            valueListenable:
                                Boxes.getTransactions().listenable(),
                            builder: (context, box, _) {
                              final transactions = box.values
                                  .where((transaction) =>
                                      transaction.account ==
                                      currentAccount.value.key)
                                  .where((transaction) =>
                                      transaction.dateTime.year == _currentYear)
                                  .where((transaction) =>
                                      transaction.dateTime.month ==
                                      _currentMonth)
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
                                      .where((transaction) =>
                                          transaction.dateTime.day == m)
                                      .toList();

                                  if (dailyTransactions.isNotEmpty) {
                                    _currentDayMap.putIfAbsent(
                                        m, () => dailyTransactions);
                                  }
                                }
                                return SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(children: [
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(width: 4),

                                              // Income
                                              countTile(
                                                  'Income', _income, color2),
                                              SizedBox(width: 10),

                                              // Expense
                                              countTile(
                                                  'Expense', _expense, color1),
                                              SizedBox(width: 10),

                                              // Total
                                              countTile(
                                                  'Total', _total, color3),

                                              SizedBox(width: 4),
                                            ],
                                          ),
                                          SizedBox(height: 15),

                                          // Transactions List
                                          ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                _currentDayMap.keys.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var _thisDay = _currentDayMap.keys
                                                  .toList()[index];

                                              return Column(
                                                children: [
                                                  Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    elevation: 3,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
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
                                                                        '${months[_currentMonth]} $_thisDay',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black54)),
                                                                    Text(
                                                                        '${dateIndent(_thisDay)}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                8,
                                                                            color:
                                                                                Colors.black54)),
                                                                    Text(
                                                                        ' | ${DateFormat('E').format(_currentDayMap[_thisDay][0].dateTime)}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black54)),
                                                                  ],
                                                                ),
                                                                Text(
                                                                    'Total: 15325',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
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
                                                                _currentDayMap[
                                                                        _thisDay]
                                                                    .length,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              var _currentAccess =
                                                                  _currentDayMap[
                                                                          _thisDay]
                                                                      .toList()[index];

                                                              return ListTile(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ManTransaction(currentState: 1)));
                                                                },
                                                                title: Text(
                                                                    '${_currentAccess.category}'),
                                                                subtitle: Text(
                                                                  '${_currentAccess.note}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                  softWrap:
                                                                      false,
                                                                ),
                                                                leading: _currentAccess
                                                                            .type ==
                                                                        1
                                                                    ? CircleAvatar(
                                                                        backgroundColor:
                                                                            Color(
                                                                                color1),
                                                                        child: Icon(
                                                                            expenseCategories[_currentAccess
                                                                                .category],
                                                                            color: Colors
                                                                                .white))
                                                                    : CircleAvatar(
                                                                        backgroundColor:
                                                                            Color(
                                                                                color2),
                                                                        child: Icon(
                                                                            incomeCategories[_currentAccess
                                                                                .category],
                                                                            color:
                                                                                Colors.white)),
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
                                                                            color:
                                                                                Color(color2))),
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
                      ),
                    ),
                  );
                });
          }
        });
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
            'No transactions found.',
            style: TextStyle(color: Colors.black45),
          ),
          Text('Add a transaction to get started.',
              style: TextStyle(color: Colors.black45))
        ],
      )),
    );
  }
}
