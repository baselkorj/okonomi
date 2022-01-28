import 'package:flutter/material.dart';

Expanded countTile(String title, double amount, int color) {
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
