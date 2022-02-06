import 'package:flutter/material.dart';

class NoInstance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: (Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.black45,
          ),
          SizedBox(height: 15),
          Text(
            'No transactions found.',
            style: TextStyle(color: Colors.black45),
          ),
          Text('Add a transaction to get started.',
              style: TextStyle(color: Colors.black45))
        ],
      )),
    );
  }
}
