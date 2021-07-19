// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookReadConfigModelAdapter extends TypeAdapter<BookReadConfigModel> {
  @override
  final int typeId = 3;

  @override
  BookReadConfigModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookReadConfigModel()
      ..index = fields[0] as int?
      ..theme = fields[1] as String?
      ..font = fields[2] as int?
      ..height = fields[3] as double?
      ..turnType = fields[4] as int?;
  }

  @override
  void write(BinaryWriter writer, BookReadConfigModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.theme)
      ..writeByte(2)
      ..write(obj.font)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.turnType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookReadConfigModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
