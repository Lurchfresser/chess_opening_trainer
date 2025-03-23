import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:bishop/bishop.dart' as bishop;
import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';

const dueDuration = Duration(seconds: 20);

class OpeningRepository {
  //TODO: refactor to use different boxes
  final Box<ChessPosition> _positionsBox = Hive.box<ChessPosition>('positions');

  numberOfPositionsFor({required bool forWhite}) {
    return _positionsBox.values
        .where((position) => position.isWhiteToMove == forWhite)
        .length;
  }

  // Get a position by FEN, create if it doesn't exist
  Future<ChessPosition> getOrCreatePosition(bishop.Game game) async {
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
      await _positionsBox.put(key, position);
    } else {
      // Update the game history if it already exists
      position.gameHistories.add(GameHistory.fromGame(game));
    }
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
    final result = move == null ? GuessResult.incorrect : GuessResult.correct;
    position.guessHistory.add(
      GuessEntry(dateTime: DateTime.now(), result: result),
    );
    return result;
  }

  //TODO: only add white or black moves
  // Add a move to a position
  Future<void> addOpeningTillHere({
    required bishop.Game game,
    required bool forWhite,
    String? comment,
  }) async {
    Queue<bishop.Move> moves = Queue();
    //avoid off by one with length and avoid "empty" move at the start of games

    final futures = <Future>[];

    while (true) {
      final algebraic = game.history.last.meta?.algebraic;
      final formatted = game.history.last.meta?.prettyName;

      if (algebraic == null || formatted == null) break;

      final move = game.undo();
      moves.addFirst(move!);
      if (_positionsBox.containsKey(normalizeFen(game.fen))) {
        break;
      }

      if ((game.turn == bishop.Bishop.white) != forWhite) {
        continue;
      }

      //TODO: This should always create

      futures.add(
        getOrCreatePosition(game).then((position) {
          position.savedMoves[algebraic] = PositionMove(
            algebraic: algebraic,
            formatted: formatted,
            comment: comment,
          );

          position.save();
        }),
      );
    }
    for (var move in moves) {
      game.makeMove(move);
    }
    debugPrint("repo${game.fen}");

    await Future.wait(futures);
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

    //TODO: implement logic for guessed other move
    final GuessEntry entry;
    entry = GuessEntry(dateTime: DateTime.now(), result: GuessResult.correct);
    positionBeforeMove.guessHistory.add(entry);
    unawaited(positionBeforeMove.save());

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
