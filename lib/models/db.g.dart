// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 0;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account()
      ..name = fields[1] as String
      ..currency = fields[2] as String
      ..type = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.currency)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 1;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction()
      ..payee = fields[0] as String
      ..account = fields[1] as String
      ..category = fields[2] as String
      ..note = fields[3] as String
      ..type = fields[4] as int
      ..amount = fields[5] as double
      ..dateTime = fields[6] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.payee)
      ..writeByte(1)
      ..write(obj.account)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
