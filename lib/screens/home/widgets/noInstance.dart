import 'package:flutter/material.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/models/style.dart';

class NoInstance extends StatelessWidget {
  final object;

  NoInstance({this.object});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: (Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Color(color8),
          ),
          SizedBox(height: 15),
          Text(
            'No $object found.',
            style: TextStyle(
                color: isDark.value ? Colors.white54 : Colors.black45),
          ),
        ],
      )),
    );
  }
}
