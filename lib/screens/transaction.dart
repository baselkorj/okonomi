import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okonomi/models/categories.dart';
import 'package:okonomi/models/colors.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

final _formKey = GlobalKey<FormState>();

class _AddTransactionState extends State<AddTransaction> {
  int _type = 0;
  int _amount = 0;
  String _name = '';
  String _payee = '';
  String _category = '';
  Color _color = color1;
  DateTime _dateTime = DateTime.now();

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    if (_type == 1) {
      _color = color1;
    } else {
      _color = color2;
    }

    double height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Transaction',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: _color,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: _color,
            child: Icon(Icons.save),
            onPressed: () async {}),
        body: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: height * 0.01, vertical: height * 0.015),
          children: [
            // Transaction Type
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction Type',
                      style:
                          TextStyle(color: _color, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _type = 0;
                              });
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: _type == 0 ? color2 : Colors.grey,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  SizedBox(width: 15),
                                  Icon(
                                    Icons.move_to_inbox,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _type = 1;
                              });
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: _type == 1 ? color1 : Colors.grey,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  SizedBox(width: 20),
                                  Icon(
                                    Icons.outbox,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Expense',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.01),

            // Amount and Payee
            Row(children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(
                              color: _color, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                            decoration: buildInputDecoration()
                                .copyWith(prefixText: 'OMR  '),
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            validator: (val) {},
                            onChanged: (val) =>
                                setState(() => _amount = val as int)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payee',
                          style: TextStyle(
                              color: _color, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                            decoration: buildInputDecoration(),
                            validator: (val) {},
                            onChanged: (val) => setState(() => _name = val)),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: height * 0.01),

            // Category and Date
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                                color: _color, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () async {
                              if (_type == 1) {
                                _color = color1;
                              } else {
                                _color = color2;
                              }

                              double height =
                                  MediaQuery.of(context).size.height;

                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: Text(
                                          'Choose Category',
                                          style: TextStyle(height: 1.5),
                                        ),
                                        content: Container(
                                            height: height * 0.5,
                                            width: height * 0.3,
                                            child: _type == 1
                                                ? ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount: expenseCategories
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        title: Text(
                                                            expenseCategories
                                                                    .keys
                                                                    .toList()[
                                                                index]),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 0.0,
                                                                right: 0.0),
                                                        leading: CircleAvatar(
                                                          backgroundColor:
                                                              _color,
                                                          child: Icon(
                                                              expenseCategories
                                                                      .values
                                                                      .toList()[
                                                                  index],
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount:
                                                        incomeCategories.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        title: Text(
                                                            incomeCategories
                                                                    .keys
                                                                    .toList()[
                                                                index]),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 0.0,
                                                                right: 0.0),
                                                        leading: CircleAvatar(
                                                          backgroundColor:
                                                              _color,
                                                          child: Icon(
                                                              incomeCategories
                                                                      .values
                                                                      .toList()[
                                                                  index],
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      );
                                                    },
                                                  )),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.black54)),
                                          ),
                                          ElevatedButton(
                                              child: Text('Yes',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              style: ElevatedButton.styleFrom(
                                                  primary: _color),
                                              onPressed: () async {})
                                        ],
                                      ));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: _color,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20),
                                  Icon(
                                    Icons.local_grocery_store,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Grocery',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: height * 0.005),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                                color: _color, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(0),
                                  lastDate: DateTime.now());
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: _color,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${_dateTime.day} ${months[_dateTime.month - 1]} ${_dateTime.year}',
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
            SizedBox(height: height * 0.01),

            // Note
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Note',
                      style:
                          TextStyle(color: _color, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                        decoration: buildInputDecoration(),
                        validator: (val) {},
                        onChanged: (val) => setState(() => _name = val)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
        errorStyle: TextStyle(height: 0),
        counterText: '',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1.5)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(width: 2, color: _color)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red)));
  }
}
