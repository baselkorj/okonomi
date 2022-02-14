import 'package:flutter/material.dart';
import 'package:okonomi/models/style.dart';

class CategoryBar extends StatelessWidget {
  final List categoryAmount;
  const CategoryBar({Key? key, required this.categoryAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> barContents = [];
    List colors = [color1, color2, color3, color4, color5, color6, color7];

    for (var i = 0; i < categoryAmount.length; i++) {
      barContents.add(Expanded(
        flex: categoryAmount[i],
        child: Container(
          color: Color(colors[i]),
        ),
      ));
    }

    return Container(
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: barContents,
        ),
      ),
    );
  }
}
