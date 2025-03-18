import 'package:chess_opening_trainer/models.dart';
import 'package:hive/hive.dart';

class OpeningRepository {
  static final Box<ChessPosition> _positionsBox = Hive.box<ChessPosition>(
    'positions',
  );

  // Get a position by FEN, create if it doesn't exist
  static ChessPosition getPosition(String fen) {
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
    ChessPosition position = getPosition(fromFen);

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
    ChessPosition position = getPosition(fen);
    return position.nextMoves.values.where((move) => move.isMainLine).toList();
  }

  // Get all moves the user has previously played from a position
  static List<PositionMove> getUserMoves(String fen) {
    ChessPosition position = getPosition(fen);
    return position.nextMoves.values
        .where((move) => move.timesPlayed > 0)
        .toList();
  }

  // Record a move played by the user
  static Future<void> recordUserMove(
    String fen,
    String move,
    bool wasCorrect,
  ) async {
    ChessPosition position = getPosition(fen);

    if (position.nextMoves.containsKey(move)) {
      PositionMove posMove = position.nextMoves[move]!;
      posMove.timesPlayed++;
      if (wasCorrect) posMove.timesCorrect++;
      await position.save();
    }
  }

  // Helper function to normalize FEN string (removing move counters if needed)
  static String normalizeFen(String fen) {
    // Just use the position part of the FEN
    return fen.split(' ').take(4).join(' ');
  }
}
