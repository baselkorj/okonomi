import 'package:flutter/material.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/models/global.dart';
import 'package:okonomi/models/style.dart';
import 'package:okonomi/screens/home/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive Flutter
  await Hive.initFlutter();

  // Register Hive Adapter from Generated File
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(AccountAdapter());

  // Open the Transactions & Accounts Box
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<Account>('accounts');

  runApp(
    RestartWidget(),
  );
}

class RestartWidget extends StatefulWidget {
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: ValueListenableBuilder(
          valueListenable: isDark,
          builder: (context, value, _) {
            updateStyle();
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: isDark.value ? ThemeData.dark() : ThemeData.light(),
                darkTheme: isDark.value ? ThemeData.dark() : ThemeData.light(),
                title: 'Okonomi Finance Manager',
                home: Home());
          }),
    );
  }
}
