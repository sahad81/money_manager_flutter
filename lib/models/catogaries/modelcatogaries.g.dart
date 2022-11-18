// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelcatogaries.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesModelAdapter extends TypeAdapter<CategoriesModel> {
  @override
  final int typeId = 1;

  @override
  CategoriesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoriesModel(
      id: fields[0] as String,
      name: fields[1] as String,
      isdeleted: fields[2] as bool,
      type: fields[3] as CategoriesType,
    );
  }

  @override
  void write(BinaryWriter writer, CategoriesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isdeleted)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoriesTypeAdapter extends TypeAdapter<CategoriesType> {
  @override
  final int typeId = 2;

  @override
  CategoriesType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CategoriesType.expense;
      case 1:
        return CategoriesType.income;
      default:
        return CategoriesType.expense;
    }
  }

  @override
  void write(BinaryWriter writer, CategoriesType obj) {
    switch (obj) {
      case CategoriesType.expense:
        writer.writeByte(0);
        break;
      case CategoriesType.income:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
