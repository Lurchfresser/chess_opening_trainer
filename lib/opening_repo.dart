import 'dart:math' as math;

import 'package:bishop/bishop.dart' as bishop;
import 'package:chess_opening_trainer/models.dart';
import 'package:hive/hive.dart';

class OpeningRepository {
  static final Box<ChessPosition> _positionsBox = Hive.box<ChessPosition>(
    'positions',
  );

  // Get a position by FEN, create if it doesn't exist
  static ChessPosition getOrCreatePosition(bishop.Game game) {
    final move = game.undo();
    // Create a normalized key from the FEN string (remove unnecessary parts)
    String key = normalizeFen(game.fen);

    // Try to find existing position
    ChessPosition? position = _positionsBox.get(key);

    // Create if it doesn't exist
    if (position == null) {
      position = ChessPosition(
        fenWithoutMoveCount: key,
        gameHistories: [GameHistory.fromGame(game)],
      );
      _positionsBox.put(key, position);
    } else {
      // Update the game history if it already exists
      position.gameHistories.add(GameHistory.fromGame(game));
    }

    game.makeMove(move!);

    return position;
  }

  // Add a move to a position
  static Future<void> addLastMove({
    required bishop.Game game,

    String? comment,
  }) async {
    ChessPosition position = getOrCreatePosition(game);

    final algebraic = game.history.last.meta!.algebraic!;
    final formatted = game.history.last.meta!.prettyName!;

    position.nextMoves[algebraic] = PositionMove(
      algebraic: algebraic,
      formatted: formatted,
      comment: comment,
    );

    await position.save();
  }

  // Get all recommended moves from a position
  static List<PositionMove> getRecommendedMoves(String fen) {
    final position = _positionsBox.get(normalizeFen(fen));
    return position?.nextMoves.values.toList() ?? [];
  }

  // Helper function to normalize FEN string (removing move counters if needed)
  static String normalizeFen(String fen) {
    // Just use the position part of the FEN
    return fen.split(' ').take(4).join(' ');
  }

  static (ChessPosition, PositionMove) getRandomMove({required bool forWhite}) {
    final positions =
        _positionsBox.values.where((position) {
          // Filter positions based on the color to move
          return (forWhite &&
                  position.fenWithoutMoveCount.split(' ')[1] == 'w') ||
              (!forWhite && position.fenWithoutMoveCount.split(' ')[1] == 'b');
        }).toList();
    if (positions.isEmpty) {
      throw Exception('No positions available');
    }

    final randomPosition = positions[math.Random().nextInt(positions.length)];
    final moves = randomPosition.nextMoves.values.toList();
    if (moves.isEmpty) {
      throw Exception('No moves available for this position');
    }
    final randomMove = moves[math.Random().nextInt(moves.length)];

    return (randomPosition, randomMove);
  }

  static void updateMovePlayed({
    required bool correct,
    required String startingFen,
    required String algebraicMove,
  }) {
    final position = _positionsBox.get(normalizeFen(startingFen));
    if (position == null) {
      throw Exception('Position not found');
    }

    final move = position.nextMoves[algebraicMove];
    if (move == null) {
      throw Exception('Move not found');
    }

    move.timesPlayed++;
    if (correct) {
      move.timesCorrect++;
    }
    position.save();
  }
}
