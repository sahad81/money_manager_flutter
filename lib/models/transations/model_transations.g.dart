// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_transations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class transationmodelAdapter extends TypeAdapter<transation_model> {
  @override
  final int typeId = 3;

  @override
  transation_model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return transation_model(
      purpose: fields[0] as String,
      ammount: fields[1] as double,
      date: fields[2] as DateTime,
      type: fields[3] as catagories_type,
      catogoryT: fields[4] as catogaries_model,
    )
      ..id = fields[5] as String?
      ..idlist = (fields[6] as List?)?.cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, transation_model obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.purpose)
      ..writeByte(1)
      ..write(obj.ammount)
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
      other is transationmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
