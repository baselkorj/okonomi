import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:okonomi/boxes.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/models/lists.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class ExportPage extends StatefulWidget {
  final currentAccount;

  ExportPage({this.currentAccount});

  @override
  _ExportPageState createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  int _color = color1;
  int _formatType = 0;
  int _exportType = 0;
  DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Recolor Page Based on Type
    if (_formatType == 0) {
      _color = color2;
    } else if (_formatType == 1) {
      _color = color1;
    } else if (_formatType == 2) {
      _color = color4;
    }
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          'Export Account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(_color),
      ),

      // Export Button
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(_color),
          child: Icon(Icons.print),
          onPressed: () async {
            exportAccount();
          }),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        children: [
          // Export Format
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Format',
                    style: TextStyle(
                        color: Color(_color), fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      typeBox(0, color2, Icons.table_chart, 'CSV'),
                      SizedBox(width: 10),
                      typeBox(1, color1, Icons.article, 'PDF'),
                      SizedBox(width: 10),
                      typeBox(2, color4, Icons.grid_view_rounded, 'XLSX'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),

          // Export Range
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Start Date
              dateSelect(),

              // End Date
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date',
                          style: TextStyle(
                              color: Color(_color),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () async {},
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(_color),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${_endDate.day} ${months[_endDate.month - 1]} ${_endDate.year}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          // Export Type
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Export Type',
                    style: TextStyle(
                        color: Color(_color), fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      exportBox(0, _color, Icons.folder_open, 'Save to Device'),
                      SizedBox(width: 10),
                      exportBox(1, _color, Icons.reply, 'Share'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded dateSelect() {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start Date',
                style: TextStyle(
                    color: Color(_color), fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () async {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(_color),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_startDate.day} ${months[_startDate.month - 1]} ${_startDate.year}',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
        ),
      ),
    );
  }

  Expanded typeBox(int type, int color, IconData icon, String name) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _formatType = type;
          });
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: formatBoxColor(type),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                icon,
                color: Colors.white,
                size: 45,
              ),
              SizedBox(width: 10),
              Text(
                '$name',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded exportBox(int type, int color, IconData icon, String name) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _exportType = type;
          });
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: type == 0
                  ? _exportType == 0
                      ? Color(color)
                      : Colors.grey
                  : _exportType == 1
                      ? Color(color)
                      : Colors.grey,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                icon,
                color: Colors.white,
                size: 45,
              ),
              SizedBox(width: 10),
              Text(
                '$name',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color formatBoxColor(type) {
    if (type == 0) {
      if (_formatType == 0) {
        return Color(color2);
      } else {
        return Colors.grey;
      }
    } else if (type == 1) {
      if (_formatType == 1) {
        return Color(color1);
      } else {
        return Colors.grey;
      }
    } else if (type == 2) {
      if (_formatType == 2) {
        return Color(color4);
      } else {
        return Colors.grey;
      }
    } else {
      return Colors.grey;
    }
  }

  Future exportAccount() async {
    final transactions = Boxes.getTransactions()
        .values
        .where(
            (transaction) => transaction.account == widget.currentAccount.key)
        .where((transaction) =>
            transaction.dateTime.isAfter(_startDate) &&
            transaction.dateTime.isBefore(_endDate))
        .toList();

    // Set File Variables
    var csv;
    var pdf;
    var xlsx;
    var file;
    String selectedDirectory = '';
    File f;

    if (_exportType == 0) {
      selectedDirectory = await getDirectory();

      if (selectedDirectory == '') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: No directory Selected."),
        ));
        return 0;
      }
    } else {
      selectedDirectory = Directory.systemTemp.path + '/';
      print(selectedDirectory);
    }

    // Call Method Based on Format Type
    if (_formatType == 0) {
      csv = await createCSV(transactions);
    } else if (_formatType == 1) {
      pdf = createPDF(transactions);
    } else if (_formatType == 2) {
      pdf = createXLSX(transactions);
    }

    // File Name Generator
    file = nameFile();

    // Call Method Based on Format Type
    if (_formatType == 0) {
      f = File('$selectedDirectory' + '${await file}' + '.csv');

      print(csv);
      f.writeAsString(csv);

      if (_exportType == 1) {
        Share.shareFiles(['$selectedDirectory' + '${await file}' + '.csv'],
            text: '${widget.currentAccount.name} Export');
      }
    } else if (_formatType == 1) {
    } else if (_formatType == 2) {}

    // Return Success Message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Success!"),
    ));

    return 0;
  }

  Future<String> getDirectory() async {
    // Get Directory
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      return '';
    } else {
      return selectedDirectory;
    }
  }

  // File Name Generator
  Future<String> nameFile() async {
    DateTime currentDate = DateTime.now();
    String name = widget.currentAccount.name.toLowerCase().replaceAll(' ', '_');
    var uuid = Uuid().v1().substring(1, 6);

    String file =
        '/${name}_${currentDate.day}_${currentDate.month}_${currentDate.year}_$uuid';

    return file;
  }

  // Create CSV
  Future<String> createCSV(transactions) async {
    List<List<dynamic>> rows = [
      ['Date', 'Type', 'Amount', 'Category', 'Notes', 'Payee']
    ];
    List row = [];
    double total = 0;

    for (var i = 0; i < transactions.length; i++) {
      // Find Total
      if (transactions[i].type == 1) {
        total -= transactions[i].amount;
      } else {
        total += transactions[i].amount;
      }

      // Create CSV File Rows
      row = [];
      row.add(transactions[i].dateTime);

      if (transactions[i].type == 1) {
        row.add('Expense');
        row.add('-${transactions[i].amount}');
      } else {
        row.add('Income');
        row.add('+${transactions[i].amount}');
      }
      row.add(transactions[i].category);
      row.add(transactions[i].note);
      row.add(transactions[i].payee);
      rows.add(row);
    }

    rows.add([]);
    rows.add(['Total:', '${widget.currentAccount.currency} $total']);

    String csv = const ListToCsvConverter().convert(rows);

    return csv;
  }

  // Create PDF File
  Future createPDF(transactions) async {}

  // Create XLSX File
  Future createXLSX(transactions) async {}
}
