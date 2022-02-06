import 'package:flutter/material.dart';

class CountTile extends StatelessWidget {
  final amount;
  final color;
  final title;

  const CountTile({Key? key, this.amount, this.color, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(color)),
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 15),
                Text(
                  '$amount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 10)
              ],
            )));
  }
}
