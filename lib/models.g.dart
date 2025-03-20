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
      fenWithoutMoveCount: fields[0] as String,
      nextMoves: (fields[1] as Map?)?.cast<String, PositionMove>(),
      gameHistories: (fields[2] as List).cast<GameHistory>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChessPosition obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.fenWithoutMoveCount)
      ..writeByte(1)
      ..write(obj.nextMoves)
      ..writeByte(2)
      ..write(obj.gameHistories);
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
      formatted: fields[1] as String,
      comment: fields[2] as String?,
      timesPlayed: fields[3] as int,
      timesCorrect: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PositionMove obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.algebraic)
      ..writeByte(1)
      ..write(obj.formatted)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.timesPlayed)
      ..writeByte(4)
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

class GameHistoryAdapter extends TypeAdapter<GameHistory> {
  @override
  final int typeId = 2;

  @override
  GameHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameHistory(
      pgn: fields[0] as String,
      moves: (fields[1] as List).cast<PositionMove>(),
    );
  }

  @override
  void write(BinaryWriter writer, GameHistory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.pgn)
      ..writeByte(1)
      ..write(obj.moves);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
