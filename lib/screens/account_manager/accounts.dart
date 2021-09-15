import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:okonomi/boxes.dart';
import 'package:okonomi/models/colors.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/screens/account_manager/add_account.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          'Manage Accounts',
        ),
        backgroundColor: Colors.black87,
      ),

      // Add Account Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add_account',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAccountPage()));
        },
        label: Text('Account'),
        icon: Icon(Icons.add),
        backgroundColor: color1,
        elevation: 4,
      ),

      // Body
      body: ValueListenableBuilder<Box<Account>>(
        valueListenable: Boxes.getAccounts().listenable(),
        builder: (context, box, _) {
          final accounts = box.values.toList().cast<Account>();

          // No Accounts
          if (accounts.isEmpty) {
            return noAccounts();
          } else {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: accounts.length,
              itemBuilder: (BuildContext context, int index) {
                final account = accounts[index];
                return Card(
                    child: ExpansionTile(
                  title: Text(
                    '${account.name}',
                    style: TextStyle(color: Color(account.color)),
                  ),
                  leading: CircleAvatar(backgroundColor: Color(account.color)),
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
                                        onPressed: () =>
                                            Navigator.pop(context)),
                                  ],
                                ));
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: color2),
                          child: Icon(Icons.edit, color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        deleteDialog(context, box, account);
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: color1),
                          child: Icon(Icons.delete, color: Colors.white)),
                    ),
                  ]),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  initiallyExpanded: true,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Opening Balance'),
                            Text('${account.openAmount}')
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Income'), Text('${account.income}')],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Expenses'),
                            Text('${account.expense}')
                          ],
                        ),
                        SizedBox(height: 2),
                        Divider(
                            thickness: 2,
                            indent: 1,
                            endIndent: 1,
                            color: Color(account.color)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Total'), Text('${account.total}')],
                        ),
                      ],
                    )
                  ],
                ));
              },
            );
          }
        },
      ),
    );
  }

  Future deleteDialog(BuildContext context, Box<Account> box, Account account) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Delete Account',
                style: TextStyle(height: 1.5),
              ),
              content: Text(
                "Are you sure you want to delete this account? You won't be able to recover any data whithin it.",
                style: TextStyle(color: Colors.black45),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: color1),
                    )),
                ElevatedButton(
                    child:
                        Text('Delete', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(primary: color1),
                    onPressed: () {
                      box.delete(account.key);
                      Navigator.pop(context);
                    }),
              ],
            ));
  }
}

class noAccounts extends StatelessWidget {
  const noAccounts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
      ),
    ));
  }
}
