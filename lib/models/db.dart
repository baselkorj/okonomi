import 'package:hive/hive.dart';
part 'db.g.dart';

// Transactions
@HiveType(typeId: 0)
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
  late String type;

  @HiveField(5)
  late double amount;

  late DateTime dateTime;
}
