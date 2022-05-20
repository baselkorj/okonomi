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
        child: Card(
            color: Color(color),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
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
              ),
            )));
  }
}
