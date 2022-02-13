import 'package:flutter/material.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/screens/account_manager/widgets/categoryBar.dart';

class AccountOverview extends StatelessWidget {
  const AccountOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Overview'),
        backgroundColor: Color(currentAccount.value.color),
      ),
      body: Padding(
          padding: EdgeInsets.all(12.0), child: Card(child: categoryBar())),
    );
  }
}
