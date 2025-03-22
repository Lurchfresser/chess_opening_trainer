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
      gameHistories: (fields[2] as List).cast<GameHistory>(),
      guessHistory: (fields[3] as List).cast<GuessEntry>(),
      comment: fields[4] as String?,
    )..savedMoves = (fields[1] as Map).cast<String, PositionMove>();
  }

  @override
  void write(BinaryWriter writer, ChessPosition obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fenWithoutMoveCount)
      ..writeByte(1)
      ..write(obj.savedMoves)
      ..writeByte(2)
      ..write(obj.gameHistories)
      ..writeByte(3)
      ..write(obj.guessHistory)
      ..writeByte(4)
      ..write(obj.comment);
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
    );
  }

  @override
  void write(BinaryWriter writer, PositionMove obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.algebraic)
      ..writeByte(1)
      ..write(obj.formatted)
      ..writeByte(2)
      ..write(obj.comment);
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

class GuessEntryAdapter extends TypeAdapter<GuessEntry> {
  @override
  final int typeId = 3;

  @override
  GuessEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GuessEntry(
      dateTime: fields[0] as DateTime,
      result: fields[1] as GuessResult,
    );
  }

  @override
  void write(BinaryWriter writer, GuessEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuessEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GuessResultAdapter extends TypeAdapter<GuessResult> {
  @override
  final int typeId = 4;

  @override
  GuessResult read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GuessResult.correct;
      case 1:
        return GuessResult.guessedOtherMove;
      case 2:
        return GuessResult.incorrect;
      default:
        return GuessResult.correct;
    }
  }

  @override
  void write(BinaryWriter writer, GuessResult obj) {
    switch (obj) {
      case GuessResult.correct:
        writer.writeByte(0);
        break;
      case GuessResult.guessedOtherMove:
        writer.writeByte(1);
        break;
      case GuessResult.incorrect:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuessResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
