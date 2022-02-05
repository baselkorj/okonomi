import 'package:flutter/material.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/models/global.dart';

class DateDialog extends StatefulWidget {
  @override
  _DateDialogState createState() => _DateDialogState();
}

class _DateDialogState extends State<DateDialog> {
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_month != 12) {
                              _month++;
                            } else {
                              _month = 1;
                            }
                          });
                        },
                        child: Icon(Icons.arrow_drop_up),
                        style: ElevatedButton.styleFrom(
                            primary: Color(currentAccount.value.color)),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 85,
                        decoration: BoxDecoration(
                          color:
                              Color(currentAccount.value.color).withAlpha(60),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Center(
                          child: Text(
                            '${months[_month]}',
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w600,
                                color: Color(currentAccount.value.color)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_month != 1) {
                              _month--;
                            } else {
                              _month = 12;
                            }
                          });
                        },
                        child: Icon(Icons.arrow_drop_down),
                        style: ElevatedButton.styleFrom(
                            primary: Color(currentAccount.value.color)),
                      ),
                    ]),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _year++;
                          });
                        },
                        child: Icon(Icons.arrow_drop_up),
                        style: ElevatedButton.styleFrom(
                            primary: Color(currentAccount.value.color)),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 85,
                        decoration: BoxDecoration(
                          color:
                              Color(currentAccount.value.color).withAlpha(60),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              '$_year',
                              style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w600,
                                  color: Color(currentAccount.value.color)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _year--;
                          });
                        },
                        child: Icon(Icons.arrow_drop_down),
                        style: ElevatedButton.styleFrom(
                            primary: Color(currentAccount.value.color)),
                      ),
                    ]),
              )
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Color(currentAccount.value.color)),
                  )),
              SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Ok'),
                style: ElevatedButton.styleFrom(
                    primary: Color(currentAccount.value.color)),
              )
            ],
          )
        ],
      ),
    );
  }
}
