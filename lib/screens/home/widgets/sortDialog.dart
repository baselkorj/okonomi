import 'package:flutter/material.dart';
import 'package:okonomi/models/global.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({Key? key}) : super(key: key);

  @override
  _SortDialogState createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sort Entries'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              InkWell(
                child: Icon(Icons.payments),
              ),
              InkWell(
                child: Icon(Icons.payments),
              ),
              InkWell(
                child: Icon(Icons.payments),
              )
            ],
          ),
        ],
      ),
    );
  }
}
