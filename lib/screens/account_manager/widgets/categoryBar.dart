import 'package:flutter/material.dart';
import 'package:okonomi/models/style.dart';

Container categoryBar() {
  List categories = [3, 1, 4, 4, 6, 2, 1];
  List<Widget> barContents = [];
  List colors = [color1, color2, color3, color4, color5, color6, color7];

  for (var i = 0; i < categories.length; i++) {
    barContents.add(Expanded(
      flex: categories[i],
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
