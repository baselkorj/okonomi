import 'package:flutter/material.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/models/style.dart';

class CategoryGrid extends StatelessWidget {
  final Map categoryAmount;
  const CategoryGrid({Key? key, required this.categoryAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List colors = [color1, color2, color3, color4, color5, color6, color7];
    List<Widget> gridContents = [];

    for (var i = 0; i < categoryAmount.length; i++) {
      gridContents.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Color(colors[i]),
            radius: 5.0,
          ),
          SizedBox(width: 10.0),
          Text(
              '${categoryAmount.keys.toList()[i]} — ${categoryAmount.values.toList()[i]}${currentAccount.value.currency}'),
          SizedBox(width: 20.0)
        ],
      ));
    }

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing: 5.0,
        children: gridContents,
      ),
    );
  }
}
