import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/screens/account_manager/account_overview.dart';
import 'package:okonomi/screens/home/widgets/dateDialog.dart';
import 'package:okonomi/screens/search/search_form.dart';

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
      systemOverlayStyle:
          isDark.value ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: Color(color9)),
      backgroundColor: isDark.value ? Colors.grey[800] : Colors.white,
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
              style: TextStyle(color: Color(color8), fontSize: 14),
            )
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchForm()));
            },
            icon: Icon(Icons.search)),
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
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountOverview()));
            },
            icon: Icon(Icons.info)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
