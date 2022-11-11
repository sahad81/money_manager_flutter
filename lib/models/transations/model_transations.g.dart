// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_transations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionmodelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 3;

  @override
  TransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      purpose: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      type: fields[3] as CategoriesType,
      catogoryT: fields[4] as CategoriesModel,
    )
      ..id = fields[5] as String?
      ..idlist = (fields[6] as List?)?.cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.purpose)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.catogoryT)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.idlist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
