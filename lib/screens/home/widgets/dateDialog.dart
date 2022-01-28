import 'package:flutter/material.dart';
import 'package:okonomi/models/lists.dart';

AlertDialog dateDialog() {
  int year = DateTime.now().year.toInt();
  List<Widget> yearTiles = [];
  List<Widget> monthTiles = [];

  for (var i = year; i > year - 20; i--) {
    yearTiles.add(ListTile(title: Text('$i')));
  }

  for (var i = 0; i < months.length; i++) {
    monthTiles.add(ListTile(title: Text('${months[i]}')));
  }

  return AlertDialog(
    title: Text(
      'Select Date',
      style: TextStyle(height: 1.5),
    ),
    content: Container(
      height: 200,
      child: Row(
        children: [
          Flexible(
            child: ListWheelScrollView(
              itemExtent: 24,
              diameterRatio: 0.5,
              children: monthTiles,
            ),
          ),
          Flexible(
            child: ListWheelScrollView(
              itemExtent: 250,
              diameterRatio: 2,
              children: yearTiles,
            ),
          ),
        ],
      ),
    ),
  );
}
