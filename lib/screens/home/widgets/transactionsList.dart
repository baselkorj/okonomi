import 'package:flutter/material.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/models/lists.dart';
import 'package:intl/intl.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/screens/transaction_manager/man_transaction.dart';

class TransactionsList extends StatelessWidget {
  final currentDayMap;
  final currentMonth;

  const TransactionsList({Key? key, this.currentDayMap, this.currentMonth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: currentDayMap.keys.length,
      itemBuilder: (BuildContext context, int index) {
        var _thisDay = currentDayMap.keys.toList()[index];

        return Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${months[currentMonth]} $_thisDay',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(color8))),
                              Text('${dateIndent(_thisDay)}',
                                  style: TextStyle(
                                      fontSize: 8, color: Color(color8))),
                              Text(
                                  ' | ${DateFormat('E').format(currentDayMap[_thisDay][0].dateTime)}',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(color8))),
                            ],
                          ),
                          Text('Total: 15325',
                              style: TextStyle(
                                  fontSize: 12, color: Color(color8))),
                        ],
                      )),
                  Divider(
                    color: Colors.black26,
                    height: 5,
                  ),
                  ListView.builder(
                      itemCount: currentDayMap[_thisDay].length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var _currentAccess =
                            currentDayMap[_thisDay].toList()[index];

                        return ListTile(
                          onTap: () {
                            currentTransaction.value = _currentAccess;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ManTransaction(currentState: 1)));
                          },
                          title: Text('${_currentAccess.category}'),
                          subtitle: Text(
                            '${_currentAccess.note}',
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                          leading: _currentAccess.type == 1
                              ? CircleAvatar(
                                  backgroundColor: Color(color1),
                                  child: Icon(
                                      expenseCategories[
                                          _currentAccess.category],
                                      color: Colors.white))
                              : CircleAvatar(
                                  backgroundColor: Color(color2),
                                  child: Icon(
                                      incomeCategories[_currentAccess.category],
                                      color: Colors.white)),
                          trailing: _currentAccess.type == 1
                              ? Text('-${_currentAccess.amount}',
                                  style: TextStyle(color: Color(color1)))
                              : Text('+${_currentAccess.amount}',
                                  style: TextStyle(color: Color(color2))),
                        );
                      }),
                ],
              ),
            ),
            SizedBox(height: 10)
          ],
        );
      },
    );
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
