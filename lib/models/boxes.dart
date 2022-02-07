import 'package:hive/hive.dart';
import 'package:okonomi/models/db.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
  static Box<Account> getAccounts() => Hive.box<Account>('accounts');
}
