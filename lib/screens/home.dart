import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:okonomi/boxes.dart';
import 'package:okonomi/models/colors.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/screens/account_manager/accounts.dart';
import 'package:okonomi/screens/account_manager/add_account.dart';
import 'package:okonomi/screens/transaction.dart';

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

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return ValueListenableBuilder<Box<Account>>(
        valueListenable: Boxes.getAccounts().listenable(),
        builder: (context, box, _) {
          final accounts = box.values.toList().cast<Account>();

          if (accounts.isEmpty) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Accounts()));
          }

          if (_updated == false) {
            _selected = accounts[0].key;
            _updated = true;
          }

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
                    SizedBox(height: h * 0.002),
                    Text(
                      "Aug 2021",
                      style:
                          TextStyle(color: Colors.black54, fontSize: h * 0.014),
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
                                      padding: EdgeInsets.all(h * 0.005),
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
                                            builder: (context) => Accounts()));
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
                  backgroundColor: color1,
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
                                )));
                  },
                  label: Text('Transaction'),
                  icon: Icon(Icons.add),
                  backgroundColor: color4,
                  elevation: 4,
                ),
              ],
            ),

            // Body
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Income
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: color2),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Income',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  '124523',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                  ),
                                ),
                                SizedBox(height: 10)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),

                        // Spending
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: color3),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Spending',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  '124523',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                  ),
                                ),
                                SizedBox(height: 10)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),

                        // Remaining
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: color1),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Remaining',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  '124523',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                  ),
                                ),
                                SizedBox(height: 10)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 1000,
                    )
                  ],
                ),
              ),
            ),
          );
        });
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
            size: 10,
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
