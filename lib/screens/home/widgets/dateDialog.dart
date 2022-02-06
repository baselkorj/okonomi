import 'package:flutter/material.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/models/global.dart';

class DateDialog extends StatefulWidget {
  var month;
  var year;

  DateDialog({this.month, this.year});

  @override
  _DateDialogState createState() => _DateDialogState();
}

class _DateDialogState extends State<DateDialog> {
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
                            if (widget.month != 12) {
                              widget.month = widget.month + 1;
                            } else {
                              widget.month = 1;
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
                            '${months[widget.month]}',
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
                            if (widget.month != 1) {
                              widget.month--;
                            } else {
                              widget.month = 12;
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
                            widget.year++;
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
                              '${widget.year}',
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
                            widget.year--;
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
                onPressed: () {
                  currentDate.value = [widget.month, widget.year];
                  Navigator.pop(context);
                },
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
