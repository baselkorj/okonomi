import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:okonomi/models/boxes.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/screens/account_manager/man_account.dart';
import 'package:okonomi/screens/home/widgets/accountActionButtons.dart';
import 'package:okonomi/screens/home/widgets/countTile.dart';
import 'package:okonomi/screens/home/widgets/homeBar.dart';
import 'package:okonomi/screens/home/widgets/noInstance.dart';
import 'package:okonomi/screens/home/widgets/transactionsList.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/screens/settings/settings.dart';

class Home extends StatefulWidget {
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
  double _income = 0;
  double _expense = 0;
  double _total = 0;

  Map _currentDayMap = {};

  int _currentMonth = currentDate.value[0];
  int _currentYear = currentDate.value[1];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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

    return ValueListenableBuilder<Box<Account>>(
        valueListenable: Boxes.getAccounts().listenable(),
        builder: (context, box, _) {
          final accounts = box.values.toList().cast<Account>();

          accounts.length == 1 ? isLastAccount = true : isLastAccount = false;

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
                    appBar: HomeBar(
                      accountName: currentAccount.value.name,
                      color: currentAccount.value.color,
                      currentMonth: _currentMonth,
                      currentYear: _currentYear,
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
                          SizedBox(height: 15),
                          Expanded(
                            child: ListView.builder(
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
                                          _selected = index;
                                          _key = accounts[_selected].key;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: accounts[index].key == _key
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
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
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
                                          leading: Icon(Icons.add_circle,
                                              size: 32, color: Color(color9)),
                                          title: Text(
                                            'Add an Account',
                                            style:
                                                TextStyle(color: Color(color9)),
                                          )),
                                      ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Settings()));
                                          },
                                          leading: Icon(Icons.settings,
                                              size: 32, color: Color(color9)),
                                          title: Text(
                                            'Settings',
                                            style:
                                                TextStyle(color: Color(color9)),
                                          )),
                                    ],
                                  )))),
                        ],
                      ),
                    ),

                    // Export Button
                    floatingActionButton: AccountActionButtons(),

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
                              _income = 0;
                              _expense = 0;
                              _total = 0;

                              currentTransactions = box.values
                                  .where((transaction) =>
                                      transaction.account ==
                                      currentAccount.value.key)
                                  .toList();

                              final filteredTransactions = currentTransactions
                                  .reversed
                                  .where((transaction) =>
                                      transaction.dateTime.year == _currentYear)
                                  .where((transaction) =>
                                      transaction.dateTime.month ==
                                      _currentMonth)
                                  .toList();

                              if (filteredTransactions.isNotEmpty) {
                                // Calculate Transactions
                                for (int i = 0;
                                    i < filteredTransactions.length;
                                    i++) {
                                  filteredTransactions[i].type == 1
                                      ? isExpense(
                                          filteredTransactions[i].amount)
                                      : isIncome(
                                          filteredTransactions[i].amount);
                                }

                                // Create Day Map
                                _currentDayMap.clear();

                                for (int m = 31; m >= 0; m--) {
                                  final dailyTransactions = filteredTransactions
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
                                              // Income
                                              CountTile(
                                                  amount: _income,
                                                  color: color2,
                                                  title: 'Income'),
                                              SizedBox(width: 5),

                                              // Expense
                                              CountTile(
                                                  amount: _expense,
                                                  color: color1,
                                                  title: 'Expense'),
                                              SizedBox(width: 5),

                                              // Total
                                              CountTile(
                                                  amount: _total,
                                                  color: color3,
                                                  title: 'Total'),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          TransactionsList(
                                              currentDayMap: _currentDayMap,
                                              currentMonth: _currentMonth),
                                          SizedBox(height: 125),
                                        ])));
                              } else {
                                return NoInstance(object: 'Transactions');
                              }
                            }),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
