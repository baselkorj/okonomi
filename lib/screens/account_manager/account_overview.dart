import 'package:flutter/material.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/screens/account_manager/widgets/categoryBar.dart';
import 'package:okonomi/screens/account_manager/widgets/categoryGrid.dart';
import 'package:okonomi/screens/home/widgets/noInstance.dart';

class AccountOverview extends StatelessWidget {
  const AccountOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Map _expenseCategories = {};
    Map _incomeCategories = {};

    if (currentTransactions.length != 0) {
      for (var i = 0; i < currentTransactions.length; i++) {
        var _currentTransaction = currentTransactions[i];
        if (_currentTransaction.type == 1) {
          if (_expenseCategories.containsKey(_currentTransaction.category)) {
            _expenseCategories.update(_currentTransaction.category,
                (value) => value + _currentTransaction.amount);
          } else {
            _expenseCategories.putIfAbsent(
                _currentTransaction.category, () => _currentTransaction.amount);
          }
        } else {
          if (_incomeCategories.containsKey(_currentTransaction.category)) {
            _incomeCategories.update(_currentTransaction.category,
                (value) => value + _currentTransaction.amount);
          } else {
            _incomeCategories.putIfAbsent(
                _currentTransaction.category, () => _currentTransaction.amount);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${currentAccount.value.name} Account Overview'),
        backgroundColor: Color(currentAccount.value.color),
      ),
      body: currentTransactions.length != 0
          ? Container(
              alignment: FractionalOffset.center,
              width:
                  screenWidth > 550 ? 550 : MediaQuery.of(context).size.width,
              child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(children: [
                    expenseCategories.length != 0
                        ? Card(
                            child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Expense Summary',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(currentAccount.value.color)),
                                ),
                                SizedBox(height: 15.0),
                                _expenseCategories.length != 0
                                    ? Column(children: [
                                        CategoryBar(
                                            categoryAmount: _expenseCategories
                                                .values
                                                .toList()),
                                        SizedBox(height: 15.0),
                                        CategoryGrid(
                                            categoryAmount: _expenseCategories)
                                      ])
                                    : NoInstance(
                                        object: 'Expense',
                                      ),
                                SizedBox(height: 15.0),
                              ],
                            ),
                          ))
                        : NoInstance(object: 'Expenses'),
                    SizedBox(height: 15.0),
                    Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Income Summary',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(currentAccount.value.color)),
                                ),
                                SizedBox(height: 15.0),
                                _incomeCategories.length != 0
                                    ? Column(children: [
                                        CategoryBar(
                                            categoryAmount: _incomeCategories
                                                .values
                                                .toList()),
                                        SizedBox(height: 15.0),
                                        CategoryGrid(
                                            categoryAmount: _incomeCategories)
                                      ])
                                    : NoInstance(
                                        object: 'Income',
                                      ),
                                SizedBox(height: 15.0),
                              ],
                            )))
                  ])),
            )
          : NoInstance(object: 'Transactions'),
    );
  }
}
