import 'package:flutter/material.dart';
import 'package:okonomi/models/style.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  State<SearchForm> createState() => _SearchFormState();
}

GlobalKey<FormState> _searchForm = GlobalKey<FormState>();

class _SearchFormState extends State<SearchForm> {
  String title = "";
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return FocusScope(
        child: Form(
            key: _searchForm,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey[800],
                title: Text("Transactions Search Form"),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Color(color1),
                child: Icon(Icons.search),
                onPressed: () {},
              ),
              body: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: screenWidth > 550
                      ? 550
                      : MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    physics: BouncingScrollPhysics(),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Account',
                                  style: TextStyle(
                                      color: Color(color1),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 10),
                                Focus(child:
                                    Builder(builder: (BuildContext context) {
                                  final FocusNode focusNode = Focus.of(context);
                                  final bool hasFocus = focusNode.hasFocus;
                                  return TextFormField(
                                      style: textStyle(hasFocus, color1),
                                      decoration: buildInputDecoration(
                                          hasFocus, color1),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) => title = value);
                                }))
                              ]),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Note Contents',
                                style: TextStyle(
                                    color: Color(color1),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10),
                              Focus(child:
                                  Builder(builder: (BuildContext context) {
                                final FocusNode focusNode = Focus.of(context);
                                final bool hasFocus = focusNode.hasFocus;
                                return TextFormField(
                                    style: textStyle(hasFocus, color1),
                                    decoration:
                                        buildInputDecoration(hasFocus, color1),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) => title = value);
                              }))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                    ]),
                  ),
                ),
              ),
            )));
  }
}
