import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/screens/home/widgets/dateDialog.dart';

class HomeBar extends StatelessWidget with PreferredSizeWidget {
  final accountName;
  final color;
  final currentMonth;
  final currentYear;

  const HomeBar(
      {Key? key,
      this.accountName,
      this.color,
      this.currentMonth,
      this.currentYear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: Colors.black87),
      title: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$accountName',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(color: Color(color)),
            ),
            SizedBox(height: 1),
            Text(
              '${months[currentMonth]} ' '$currentYear',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DateDialog(
                    month: currentMonth,
                    year: currentYear,
                  );
                },
              );
            },
            icon: Icon(Icons.event)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
