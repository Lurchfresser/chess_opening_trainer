import 'dart:math' as math;

import 'package:bishop/bishop.dart' as bishop;
import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:hive/hive.dart';

const dueDuration = Duration(seconds: 20);

class OpeningRepository {
  final Box<ChessPosition> _positionsBox = Hive.box<ChessPosition>('positions');

  numberOfPositionsFor({required bool forWhite}) {
    return _positionsBox.values
        .where((position) => position.isWhiteToMove == forWhite)
        .length;
  }

  // Get a position by FEN, create if it doesn't exist
  ChessPosition getOrCreatePosition(bishop.Game game) {
    final move = game.undo();
    // Create a normalized key from the FEN string (remove unnecessary parts)
    String key = normalizeFen(game.fen);

    // Try to find existing position
    ChessPosition? position = _positionsBox.get(key);

    // Create if it doesn't exist
    if (position == null) {
      position = ChessPosition(
        guessHistory: [],
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

  ChessPosition? getPosition(String fen) {
    fen = normalizeFen(fen);

    return _positionsBox.get(fen);
  }

  GuessResult addGuess({required String fen, required String algebraic}) {
    final position = getPosition(fen);
    if (position == null) {
      throw Exception("game not found");
    }

    final move = position.savedMoves[algebraic];
    final result = move == null ? GuessResult.incorrect : GuessResult.incorrect;
    position.guessHistory.add(
      GuessEntry(dateTime: DateTime.now(), result: result),
    );
    return result;
  }

  // Add a move to a position
  Future<void> addLastMove({required bishop.Game game, String? comment}) async {
    ChessPosition position = getOrCreatePosition(game);

    final algebraic = game.history.last.meta!.algebraic!;
    final formatted = game.history.last.meta!.prettyName!;

    position.savedMoves[algebraic] = PositionMove(
      algebraic: algebraic,
      formatted: formatted,
      comment: comment,
    );

    await position.save();
  }

  // Get all recommended moves from a position
  List<PositionMove> getRecommendedMoves(String fen) {
    final position = _positionsBox.get(normalizeFen(fen));
    return position?.savedMoves.values.toList() ?? [];
  }

  // Helper function to normalize FEN string (removing move counters if needed)
  String normalizeFen(String fen) {
    // Just use the position part of the FEN
    return fen.split(' ').take(4).join(' ');
  }

  ChessPosition getRandomPosition({required bool forWhite}) {
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
    final moves = randomPosition.savedMoves.values.toList();
    if (moves.isEmpty) {
      throw Exception('No moves available for this position');
    }
    return randomPosition;
  }

  GuessResult updateMovePlayed({required bishop.Game gameAfterMove}) {
    final move = gameAfterMove.undo();
    final positionBeforeMove = _positionsBox.get(
      normalizeFen(gameAfterMove.fen),
    );
    gameAfterMove.makeMove(move!);

    if (positionBeforeMove == null) {
      throw Exception('Position not found');
    }

    final positionMove =
        positionBeforeMove.savedMoves[gameAfterMove
            .history
            .last
            .meta!
            .algebraic];

    //TODO: implement logic for guessed other move
    final GuessEntry entry;
    entry = GuessEntry(dateTime: DateTime.now(), result: GuessResult.correct);
    positionBeforeMove.guessHistory.add(entry);
    positionBeforeMove.save();

    return entry.result;
  }

  List<ChessPosition> getMostDuePositions({
    required int numberOfPositions,
    required bool forWhite,
  }) {
    final positions =
        _positionsBox.values
            .where((position) => position.isWhiteToMove == forWhite)
            .toList();

    // Sort positions by the number of guesses
    positions.sort((a, b) {
      final aDuePoints = _duePoints(a.guessHistory);
      final bDuePoints = _duePoints(b.guessHistory);
      return aDuePoints.compareTo(bDuePoints);
    });

    // Return the most due positions
    return positions.take(numberOfPositions).toList()..shuffle();
  }
}

int _duePoints(List<GuessEntry> guessHistory) {
  return guessHistory.take(3).fold(0, (sum, entry) {
    final timePoints =
        entry.dateTime.isBefore(DateTime.now().subtract(dueDuration)) ? 1 : 0;
    final guessPoints = entry.result == GuessResult.correct ? 0 : 2;
    return sum + timePoints + guessPoints;
  });
}
