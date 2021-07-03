import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:okonomi/models/colors.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // App Bar
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal',
              style: TextStyle(color: Colors.black87),
            ),
            SizedBox(height: height * 0.002),
            Text(
              "Aug 2021",
              style: TextStyle(color: Colors.black54, fontSize: height * 0.014),
            )
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.event)),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),

      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
            },
            label: Text('Export'),
            icon: Icon(Icons.print),
            backgroundColor: color1,
            elevation: 4,
          ),
          SizedBox(height: height * 0.01),
          FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
            },
            label: Text('Transaction'),
            icon: Icon(Icons.add),
            backgroundColor: color4,
            elevation: 4,
          ),
        ],
      ),
      // Body
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: height * 0.01),
          child: Column(
            children: [
              SizedBox(height: height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Income
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(height * 0.01),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: height * 0.001,
                              blurRadius: height * 0.004,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * 0.005)),
                          color: color2),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Income',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            '124523',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: height * 0.01)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: height * 0.01),

                  // Spending
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(height * 0.01),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: height * 0.001,
                              blurRadius: height * 0.004,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * 0.005)),
                          color: color3),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Spending',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            '124523',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: height * 0.01)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: height * 0.01),

                  // Remaining
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(height * 0.01),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: height * 0.001,
                              blurRadius: height * 0.004,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * 0.005)),
                          color: color1),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Remaining',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            '124523',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: height * 0.01)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.015),
              Container(
                padding: EdgeInsets.all(height * 0.01),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(height * 0.005)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: height * 0.001,
                      blurRadius: height * 0.004,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                height: height * 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
