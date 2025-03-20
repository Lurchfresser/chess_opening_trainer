import 'package:bishop/bishop.dart' as bishop;
import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class ChessPosition extends HiveObject {
  @HiveField(0)
  String fenWithoutMoveCount; // The FEN string that uniquely identifies this position

  @HiveField(1)
  Map<String, PositionMove> nextMoves; // Key is the move in algebraic notation

  @HiveField(2)
  List<GameHistory> gameHistories; // List of game histories for this position

  ChessPosition({
    required this.fenWithoutMoveCount,
    Map<String, PositionMove>? nextMoves, // Make this nullable
    required this.gameHistories,
  }) : nextMoves =
           nextMoves != null
               ? Map<String, PositionMove>.of(nextMoves)
               : {}; // Ensure it's modifiable

  bool get isWhiteToMove => fenWithoutMoveCount.split(' ')[1] == 'w';
}

@HiveType(typeId: 1)
class PositionMove extends HiveObject {
  @HiveField(0)
  String algebraic; // The move in algebraic notation (e.g., "e4")

  @HiveField(1)
  String formatted;

  @HiveField(2)
  String? comment; // Optional comment about this move

  @HiveField(3)
  int timesPlayed;

  @HiveField(4)
  int timesCorrect;

  PositionMove({
    required this.algebraic,
    required this.formatted,
    this.comment,
    this.timesPlayed = 0,
    this.timesCorrect = 0,
  });
}

@HiveType(typeId: 2)
class GameHistory extends HiveObject {
  @HiveField(0)
  String pgn;

  @HiveField(1)
  List<PositionMove> moves;

  GameHistory({required this.pgn, required this.moves});

  factory GameHistory.fromGame(bishop.Game game) {
    final pgn = game.pgn();
    final moves = <PositionMove>[];
    for (var i = 1; i < game.history.length; i++) {
      final move = game.history[i];
      moves.add(
        PositionMove(
          algebraic: move.meta!.algebraic!,
          formatted: move.meta!.prettyName!,
        ),
      );
    }
    return GameHistory(pgn: pgn, moves: moves);
  }
}

extension GameFromPosition on bishop.Game {
  /// Returns a [Game] object from a [ChessPosition].
  static bishop.Game fromPosition(ChessPosition position) {
    if (position.gameHistories.isEmpty) {
      final game = bishop.Game(
        variant: bishop.Variant.standard(),
        fen: position.fenWithoutMoveCount,
      );
      return game;
    }
    final game = bishop.Game(variant: bishop.Variant.standard());
    for (var move in position.gameHistories.first.moves) {
      for (var legalMove in game.generateLegalMoves()) {
        game.makeMove(legalMove);
        final algebraic = game.history.last.meta!.algebraic!;
        if (move.algebraic == algebraic) {
          //move was already played
          break;
        } else {
          game.undo();
        }
      }
    }
    return game;
  }
}
