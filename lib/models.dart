import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class ChessPosition extends HiveObject {
  @HiveField(0)
  String fen; // The FEN string that uniquely identifies this position

  @HiveField(1)
  Map<String, PositionMove> nextMoves = {}; // Key is the move in algebraic notation

  @HiveField(2)
  bool isInRepertoire = false; // Whether this position is part of user's repertoire

  ChessPosition({
    required this.fen,
    this.nextMoves = const {},
    this.isInRepertoire = false,
  });
}

@HiveType(typeId: 1)
class PositionMove extends HiveObject {
  @HiveField(0)
  String algebraic; // The move in algebraic notation (e.g., "e4")

  @HiveField(1)
  String resultingFen; // FEN after this move is played

  @HiveField(2)
  String? comment; // Optional comment about this move

  @HiveField(3)
  bool isMainLine = false; // Whether this is the main recommendation

  @HiveField(4)
  int timesPlayed = 0; // Times the user has played this move

  @HiveField(5)
  int timesCorrect = 0; // Times the user played correctly

  PositionMove({
    required this.algebraic,
    required this.resultingFen,
    this.comment,
    this.isMainLine = false,
    this.timesPlayed = 0,
    this.timesCorrect = 0,
  });
}
