import 'dart:math' as math;

import 'package:chess_opening_trainer/models.dart';
import 'package:hive/hive.dart';

class OpeningRepository {
  static final Box<ChessPosition> _positionsBox = Hive.box<ChessPosition>(
    'positions',
  );

  // Get a position by FEN, create if it doesn't exist
  static ChessPosition getOrCreatePosition(String fen) {
    // Create a normalized key from the FEN string (remove unnecessary parts)
    String key = normalizeFen(fen);

    // Try to find existing position
    ChessPosition? position = _positionsBox.get(key);

    // Create if it doesn't exist
    if (position == null) {
      position = ChessPosition(fen: key);
      _positionsBox.put(key, position);
    }

    return position;
  }

  // Add a move to a position
  static Future<void> addMove({
    required String fromFen,
    required String algebraic,
    required String formatted,
    required String toFen,
    bool isMainLine = false,
    String? comment,
  }) async {
    ChessPosition position = getOrCreatePosition(fromFen);

    position.nextMoves[algebraic] = PositionMove(
      algebraic: algebraic,
      formatted: formatted,
      resultingFen: toFen,
      isMainLine: isMainLine,
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

  static (ChessPosition, PositionMove) getRandomMove() {
    final positions = _positionsBox.values.toList();
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
