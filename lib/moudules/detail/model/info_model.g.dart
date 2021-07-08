// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookDetailInfoModelAdapter extends TypeAdapter<BookDetailInfoModel> {
  @override
  final int typeId = 1;

  @override
  BookDetailInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookDetailInfoModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      img: fields[2] as String?,
      author: fields[3] as String?,
      desc: fields[4] as String?,
      cName: fields[5] as String?,
      bookVote: fields[6] as BookVote?,
    );
  }

  @override
  void write(BinaryWriter writer, BookDetailInfoModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.desc)
      ..writeByte(5)
      ..write(obj.cName)
      ..writeByte(6)
      ..write(obj.bookVote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookDetailInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BookVoteAdapter extends TypeAdapter<BookVote> {
  @override
  final int typeId = 2;

  @override
  BookVote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookVote(
      bookId: fields[0] as int?,
      totalScore: fields[1] as int?,
      voterCount: fields[2] as int?,
      score: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, BookVote obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.totalScore)
      ..writeByte(2)
      ..write(obj.voterCount)
      ..writeByte(3)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookVoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
