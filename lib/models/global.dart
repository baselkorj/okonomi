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
