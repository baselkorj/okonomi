import 'package:flutter/material.dart';
import 'package:okonomi/models/db.dart';
import 'package:okonomi/models/shared.dart';
import 'package:okonomi/screens/home.dart';
import 'package:hive/hive.dart';
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.light,
        ),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: 'Okonomi Finance Manager',
        home: Home());
  }
}
