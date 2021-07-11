import 'package:hive/hive.dart';
part 'db.g.dart';

// Accounts
@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(1)
  late String name;

  @HiveField(2)
  late String currency;

  @HiveField(3)
  late int color;

  @HiveField(4)
  late int openAmount;

  @HiveField(5)
  late int income;

  @HiveField(6)
  late int expense;

  @HiveField(7)
  late int total;
}

// Transactions
@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  late String payee;

  @HiveField(1)
  late String account;

  @HiveField(2)
  late String category;

  @HiveField(3)
  late String note;

  @HiveField(4)
  late int type;

  @HiveField(5)
  late double amount;

  @HiveField(6)
  late DateTime dateTime;
}
