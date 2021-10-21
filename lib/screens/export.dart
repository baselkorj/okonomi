import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okonomi/boxes.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/models/lists.dart';
import 'package:pdf/widgets.dart' as pdfWid;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
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

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
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

        // Body
        body: Align(
            alignment: FractionalOffset.topCenter,
            child: Container(
              width:
                  screenWidth > 550 ? 550 : MediaQuery.of(context).size.width,
              child: ListView(
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
                                color: Color(_color),
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              typeBox(0, color2, Icons.table_chart, 'CSV'),
                              SizedBox(width: 10),
                              typeBox(1, color1, Icons.article, 'PDF'),
                              SizedBox(width: 10),
                              typeBox(
                                  2, color4, Icons.grid_view_rounded, 'XLSX'),
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
                      dateSelect('Start', _startDate),

                      // End Date
                      dateSelect('End', _endDate)
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
                                color: Color(_color),
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              exportBox(0, _color, Icons.folder_open,
                                  'Save to Device'),
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
            )));
  }

  Expanded dateSelect(String pos, DateTime dateTime) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$pos Date',
                style: TextStyle(
                    color: Color(_color), fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  final DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: dateTime,
                    firstDate: pos == 'Start'
                        ? DateTime(0)
                        : _startDate.add(Duration(days: 1)),
                    lastDate: pos == 'Start'
                        ? _endDate.subtract(Duration(days: 1))
                        : DateTime.now(),
                  );
                  if (selectedDate != null && selectedDate != dateTime) {
                    if (pos == 'Start') {
                      setState(() {
                        _startDate = selectedDate;
                      });
                    } else {
                      setState(() {
                        _endDate = selectedDate;
                      });
                    }
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(_color),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}',
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
      xlsx = createXLSX(transactions);
    }

    // File Name Generator
    file = nameFile();

    // Call Method Based on Format Type
    if (_formatType == 0) {
      f = File('$selectedDirectory' + '${await file}' + '.csv');

      f.writeAsString(csv);

      if (_exportType == 1) {
        Share.shareFiles(['$selectedDirectory' + '${await file}' + '.csv'],
            text: '${widget.currentAccount.name} Export');
      }
    } else if (_formatType == 1) {
      f = File('$selectedDirectory' + '${await file}' + '.pdf');

      f.writeAsBytes(await pdf);

      if (_exportType == 1) {
        Share.shareFiles(['$selectedDirectory' + '${await file}' + '.pdf'],
            text: '${widget.currentAccount.name} Export');
      }
    } else if (_formatType == 2) {
      f = File('$selectedDirectory' + '${await file}' + '.xlsx');

      f.writeAsBytes(await xlsx);

      if (_exportType == 1) {
        Share.shareFiles(['$selectedDirectory' + '${await file}' + '.xlsx'],
            text: '${widget.currentAccount.name} Export');
      }
    }

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
    List<String> headers = [
      'Date',
      'Type',
      'Amount',
      'Category',
      'Notes',
      'Payee'
    ];

    List<List<dynamic>> entries = createEntries(transactions);

    entries.insert(0, headers);

    String csv = const ListToCsvConverter().convert(entries);

    return csv;
  }

  // Create PDF File
  Future<List<int>> createPDF(transactions) async {
    List<String> headers = [
      'Date',
      'Type',
      'Amount',
      'Category',
      'Notes',
      'Payee'
    ];

    List<List<dynamic>> entries = createEntries(transactions);

    final pdf = pdfWid.Document();

    pdf.addPage(pdfWid.Page(
      build: (context) => pdfWid.Table.fromTextArray(
        headers: headers,
        data: entries,
      ),
    ));

    final bytes = await pdf.save();

    return bytes;
  }

  // Create XLSX File
  Future<List<int>> createXLSX(transactions) async {
    final workbook = xlsio.Workbook();
    final sheet = workbook.worksheets[0];

    // Set Headers
    sheet.getRangeByName('A1').setText('Date');
    sheet.getRangeByName('B1').setText('Type');
    sheet.getRangeByName('C1').setText('Amount');
    sheet.getRangeByName('D1').setText('Category');
    sheet.getRangeByName('E1').setText('Notes');
    sheet.getRangeByName('F1').setText('Payee');

    // Generate List of Entries
    List<List<dynamic>> entries = createEntries(transactions);

    // Iterate Through Entries and Import to Sheet
    for (var i = 0; i < entries.length; i++) {
      sheet.importList(entries[i], i + 2, 1, false);
    }

    final List<int> bytes = workbook.saveAsStream();

    workbook.dispose();

    return bytes;
  }

  // Create List of Entries
  List<List<dynamic>> createEntries(transactions) {
    List<List<dynamic>> entries = [];
    List entry = [];

    double total = 0;

    for (var i = 0; i < transactions.length; i++) {
      // Find Total
      if (transactions[i].type == 1) {
        total -= transactions[i].amount;
      } else {
        total += transactions[i].amount;
      }

      // Create CSV File Rows
      entry = [];
      entry.add(
          '${transactions[i].dateTime.day}/${transactions[i].dateTime.month}/${transactions[i].dateTime.year}');

      if (transactions[i].type == 1) {
        entry.add('Expense');
        entry.add('-${transactions[i].amount}');
      } else {
        entry.add('Income');
        entry.add('+${transactions[i].amount}');
      }
      entry.add(transactions[i].category);
      entry.add(transactions[i].note);
      entry.add(transactions[i].payee);
      entries.add(entry);
    }

    entries.add(['', '', '$total']);

    return entries;
  }
}
