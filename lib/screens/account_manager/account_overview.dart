import 'package:flutter/material.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/screens/account_manager/widgets/categoryBar.dart';
import 'package:okonomi/screens/account_manager/widgets/categoryGrid.dart';

class AccountOverview extends StatelessWidget {
  const AccountOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map _categoryAmount = {
      'Car': 21,
      'Boat': 123,
      'Train': 54,
      'Bills': 62,
      'Family': 90,
      'College': 15
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Overview'),
        backgroundColor: Color(currentAccount.value.color),
      ),
      body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Category Summary',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(currentAccount.value.color)),
                ),
                SizedBox(height: 15.0),
                CategoryBar(categoryAmount: _categoryAmount.values.toList()),
                SizedBox(height: 15.0),
                CategoryGrid(categoryAmount: _categoryAmount)
              ],
            ),
          ))),
    );
  }
}
