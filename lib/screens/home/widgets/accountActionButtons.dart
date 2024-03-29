import 'package:flutter/material.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/screens/transaction_manager/export.dart';
import 'package:okonomi/screens/transaction_manager/man_transaction.dart';

class AccountActionButtons extends StatelessWidget {
  const AccountActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          heroTag: 'export',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ExportPage()));
          },
          label: Text(
            'Export',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.print,
            color: Colors.white,
          ),
          backgroundColor: Color(color1),
          elevation: 4,
        ),
        SizedBox(height: 10),
        FloatingActionButton.extended(
          heroTag: 'add_transaction',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ManTransaction(currentState: 0)));
          },
          label: Text(
            'Transaction',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.add, color: Colors.white),
          backgroundColor: Color(color4),
          elevation: 4,
        ),
      ],
    );
  }
}
