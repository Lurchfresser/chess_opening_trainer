import 'package:bishop/bishop.dart' as bishop;
import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class ChessPosition extends HiveObject {
  @HiveField(0)
  String fenWithoutMoveCount; // The FEN string that uniquely identifies this position

  @HiveField(1)
  /// Map of possible moves from this position, the key is the move in algebraic notation
  Map<String, PositionMove> savedMoves;

  @HiveField(2)
  List<GameHistory> gameHistories; // List of game histories for this position

  @HiveField(3)
  List<GuessEntry> guessHistory;

  @HiveField(4)
  String? comment;

  ChessPosition({
    required this.fenWithoutMoveCount,
    Map<String, PositionMove>? nextMoves, // Make this nullable
    required this.gameHistories,
    required this.guessHistory,
    this.comment,
  }) : savedMoves =
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

  PositionMove({
    required this.algebraic,
    required this.formatted,
    this.comment,
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

@HiveType(typeId: 3)
class GuessEntry extends HiveObject {
  @HiveField(0)
  final DateTime dateTime;

  @HiveField(1)
  final GuessResult result;

  GuessEntry({required this.dateTime, required this.result});
}

@HiveType(typeId: 4)
enum GuessResult {
  @HiveField(0)
  correct,
  @HiveField(1)
  guessedOtherMove,
  @HiveField(2)
  incorrect,
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
