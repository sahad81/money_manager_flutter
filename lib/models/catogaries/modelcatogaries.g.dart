// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelcatogaries.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class catogariesmodelAdapter extends TypeAdapter<catogaries_model> {
  @override
  final int typeId = 1;

  @override
  catogaries_model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return catogaries_model(
      id: fields[0] as String,
      name: fields[1] as String,
      is_deleted: fields[2] as bool,
      type: fields[3] as catagories_type,
    );
  }

  @override
  void write(BinaryWriter writer, catogaries_model obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.is_deleted)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is catogariesmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class catagoriestypeAdapter extends TypeAdapter<catagories_type> {
  @override
  final int typeId = 2;

  @override
  catagories_type read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return catagories_type.expense;
      case 1:
        return catagories_type.income;
      default:
        return catagories_type.expense;
    }
  }

  @override
  void write(BinaryWriter writer, catagories_type obj) {
    switch (obj) {
      case catagories_type.expense:
        writer.writeByte(0);
        break;
      case catagories_type.income:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is catagoriestypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
