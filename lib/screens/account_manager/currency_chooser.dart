import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okonomi/models/lists.dart';
import 'package:okonomi/screens/account_manager/account_global.dart' as global;

class CurrencyChooser extends StatefulWidget {
  const CurrencyChooser({Key? key}) : super(key: key);

  @override
  _CurrencyChooserState createState() => _CurrencyChooserState();
}

class _CurrencyChooserState extends State<CurrencyChooser> {
  Map _currentList = searchMap('');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,

          // Search Box
          title: Container(
            height: 30,
            child: TextField(
              autofocus: true,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: buildInputDecoration()
                  .copyWith(hintText: 'Search Currencies'),
              onChanged: (val) {
                setState(() => _currentList = searchMap(val));
              },
            ),
          ),
          backgroundColor: Colors.black87,
        ),

        // Currency List
        body: Align(
          alignment: FractionalOffset.topCenter,
          child: Container(
            width: screenWidth > 550 ? 550 : MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _currentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                  '${_currentList.values.toList()[index][0]}'),
                              subtitle:
                                  Text('${_currentList.keys.toList()[index]}'),
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  '${_currentList.values.toList()[index][1]}',
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                              onTap: () {
                                global.currentCurrency.value =
                                    _currentList.keys.toList()[index];
                                Navigator.pop(context);
                              },
                            ),
                            Divider(),
                          ],
                        );
                      }),
                ),
              ),
            ),
          ),
        ));
  }

  // Input Decoration
  InputDecoration buildInputDecoration() {
    return InputDecoration(
        errorStyle: TextStyle(height: 0),
        counterText: '',
        fillColor: Colors.white12,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white10, width: 0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.white10)));
  }
}

Map searchMap(String searchQuery) {
  Map _searchedMap = {};

  for (var i = 0; i < currenciesSymbolic.length; i++) {
    if (currenciesSymbolic.values.toList()[i][0].contains(searchQuery)) {
      _searchedMap.putIfAbsent(currenciesSymbolic.keys.toList()[i],
          () => currenciesSymbolic.values.toList()[i]);
    } else if (currenciesSymbolic.values
        .toList()[i][0]
        .toString()
        .toLowerCase()
        .contains(searchQuery)) {
      _searchedMap.putIfAbsent(currenciesSymbolic.keys.toList()[i],
          () => currenciesSymbolic.values.toList()[i]);
    } else if (currenciesSymbolic.values
        .toList()[i][0]
        .toString()
        .toUpperCase()
        .contains(searchQuery)) {
      _searchedMap.putIfAbsent(currenciesSymbolic.keys.toList()[i],
          () => currenciesSymbolic.values.toList()[i]);
    } else if (currenciesSymbolic.keys.toList()[i].contains(searchQuery)) {
      _searchedMap.putIfAbsent(currenciesSymbolic.keys.toList()[i],
          () => currenciesSymbolic.values.toList()[i]);
    } else if (currenciesSymbolic.keys
        .toList()[i]
        .toString()
        .toLowerCase()
        .contains(searchQuery)) {
      _searchedMap.putIfAbsent(currenciesSymbolic.keys.toList()[i],
          () => currenciesSymbolic.values.toList()[i]);
    }
  }

  return _searchedMap;
}
