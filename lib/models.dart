import 'package:bishop/bishop.dart' as bishop;
import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class ChessPosition extends HiveObject {
  @HiveField(0)
  String fen; // The FEN string that uniquely identifies this position

  @HiveField(1)
  Map<String, PositionMove> nextMoves; // Key is the move in algebraic notation

  @HiveField(2)
  bool isInRepertoire;

  ChessPosition({
    required this.fen,
    Map<String, PositionMove>? nextMoves, // Make this nullable
    this.isInRepertoire = false,
  }) : nextMoves =
           nextMoves != null
               ? Map<String, PositionMove>.of(nextMoves)
               : {}; // Ensure it's modifiable
}

@HiveType(typeId: 1)
class PositionMove extends HiveObject {
  @HiveField(0)
  String algebraic; // The move in algebraic notation (e.g., "e4")

  @HiveField(6)
  String formatted;

  @HiveField(1)
  String resultingFen; // FEN after this move is played

  @HiveField(2)
  String? comment; // Optional comment about this move

  @HiveField(3)
  bool isMainLine;

  @HiveField(4)
  int timesPlayed;

  @HiveField(5)
  int timesCorrect;

  PositionMove({
    required this.algebraic,
    required this.resultingFen,
    required this.formatted,
    this.comment,
    this.isMainLine = false,
    this.timesPlayed = 0,
    this.timesCorrect = 0,
  });
}

extension GameFromPosition on bishop.Game {
  /// Returns a [Game] object from a [ChessPosition].
  static bishop.Game fromPosition(ChessPosition position) {
    final game = bishop.Game(
      variant: bishop.Variant.standard(),
      fen: position.fen,
    );
    return game;
  }
}
