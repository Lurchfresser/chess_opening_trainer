// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChessPositionAdapter extends TypeAdapter<ChessPosition> {
  @override
  final int typeId = 0;

  @override
  ChessPosition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChessPosition(
      fen: fields[0] as String,
      nextMoves: (fields[1] as Map?)?.cast<String, PositionMove>(),
      isInRepertoire: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ChessPosition obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.fen)
      ..writeByte(1)
      ..write(obj.nextMoves)
      ..writeByte(2)
      ..write(obj.isInRepertoire);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChessPositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PositionMoveAdapter extends TypeAdapter<PositionMove> {
  @override
  final int typeId = 1;

  @override
  PositionMove read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionMove(
      algebraic: fields[0] as String,
      resultingFen: fields[1] as String,
      formatted: fields[6] as String,
      comment: fields[2] as String?,
      isMainLine: fields[3] as bool,
      timesPlayed: fields[4] as int,
      timesCorrect: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PositionMove obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.algebraic)
      ..writeByte(6)
      ..write(obj.formatted)
      ..writeByte(1)
      ..write(obj.resultingFen)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.isMainLine)
      ..writeByte(4)
      ..write(obj.timesPlayed)
      ..writeByte(5)
      ..write(obj.timesCorrect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionMoveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
