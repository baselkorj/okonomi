import 'package:flutter/foundation.dart';
import 'package:okonomi/models/db.dart';

ValueNotifier<Account> currentAccount = ValueNotifier(Account()
  ..name = ''
  ..currency = 'AED'
  ..color = 0xFFCB576C
  ..openAmount = 0.0
  ..income = 0.0
  ..expenses = 0.0
  ..goalLimit = 0.0);

ValueNotifier<Transaction> currentTransaction = ValueNotifier(Transaction()
  ..account = 0
  ..amount = 0.0
  ..category = 'Other'
  ..dateTime = DateTime.now()
  ..note = ''
  ..payee = ''
  ..type = 1);

List<Transaction> currentTransactions = [];

ValueNotifier currentCurrency = ValueNotifier('AED');
ValueNotifier currentDate =
    ValueNotifier([DateTime.now().month, DateTime.now().year]);

ValueNotifier isDark = ValueNotifier(false);
