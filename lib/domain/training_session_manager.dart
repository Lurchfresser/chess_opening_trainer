import 'package:bishop/bishop.dart' as bishop;
import 'package:chess_opening_trainer/domain/building_notifier.dart';
import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:flutter/rendering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:square_bishop/square_bishop.dart' as squares;
import 'package:squares/squares.dart' as squares;

part 'training_session_manager.g.dart';

@riverpod
class RandomTrainingSessionManager extends _$RandomTrainingSessionManager
    implements MyTrainingNotifyer {
  late final _positions = ref.read(
    duePositionsProvider.call(
      forWhite: forWhite,
      numberOfPositions: numberOfPositions,
    ),
  );

  @override
  bishop.Game build(bool forWhite, int numberOfPositions) {
    _loadNextPosition();
    return state;
  }

  @override
  //returns the success of the move
  Future<GuessResult?> onMove(
    squares.Move move,
    Duration animationDuration,
  ) async {
    if (_positions.isEmpty) {
      return null;
    }
    final fenBefore = state.fenNormalized;
    bool moveResult = state.makeSquaresMove(move);
    if (!moveResult) {
      return null;
    }
    final guessResult = ref.read(
      guessProvider(
        //TODO:
        repoName: forWhite ? "white" : "black",
        fen: fenBefore,
        algebraic: state.history.last.meta!.algebraic!,
      ),
    );

    final bool correct = guessResult != GuessResult.incorrect;

    await Future.delayed(animationDuration);

    if (correct) {
      _positions.removeAt(0);
      _loadNextPosition();
    } else {
      await Future.delayed(Duration(milliseconds: 150));
      state.undo();
    }
    return guessResult;
  }

  void _loadNextPosition() {
    if (_positions.isNotEmpty) {
      final chessPosition = _positions.first;
      state = GameFromPosition.fromPosition(chessPosition);
    } else {
      debugPrint("No more positions available!");
    }
    ref.notifyListeners();
  }
}

@riverpod
class RecursiveTrainingSessionManager extends _$RecursiveTrainingSessionManager
    implements MyTrainingNotifyer {
  final Map<String, int> _visitedPositions = {};
  @override
  bishop.Game build(bool forWhite) {
    return bishop.Game();
  }

  @override
  //returns the success of the move
  Future<GuessResult?> onMove(
    squares.Move move,
    Duration animationDuration,
  ) async {
    final fenBefore = state.fenNormalized;
    bool moveResult = state.makeSquaresMove(move);
    if (!moveResult) {
      return null;
    }

    GuessResult guessResult = ref.read(
      guessProvider(
        //TODO:
        repoName: forWhite ? "white" : "black",
        fen: fenBefore,
        algebraic: state.history.last.meta!.algebraic!,
      ),
    );
    await Future.delayed(animationDuration);
    switch (guessResult) {
      case GuessResult.incorrect:
      case GuessResult.guessedOtherMove:
        await Future.delayed(Duration(milliseconds: 150));
        state.undo();
      case GuessResult.correct:
        if ((_visitedPositions[state.fenNormalized] ?? -1) > 0) {
          guessResult = GuessResult.guessedOtherMove;
          state.undo();
          break;
        }
        _visitedPositions.update(
          state.fenNormalized,
          (val) => val + 1,
          ifAbsent: () => 1,
        );
        _visitedPositions.update(
          fenBefore,
          (val) => val + 1,
          ifAbsent: () => 1,
        );

        _loadNextPosition();
    }
    return guessResult;
  }

  void _loadNextPosition() {
    assert(
      (state.state.turn == bishop.Bishop.white) != forWhite,
      "_loadNextPosition should start from enemy perspective",
    );
    final nextPossibleMoves = state.generateLegalMoves();
    for (var i = 0; i < nextPossibleMoves.length; i++) {
      final move = nextPossibleMoves[i];
      state.makeMove(move);
      //TODO:
      final savedMoves = ref.read(
        savedMovesProvider(
          fen: state.fenNormalized,
          repoName: forWhite ? "white" : "black",
        ),
      );
      if (savedMoves.isEmpty ||
          (_visitedPositions[state.fenNormalized] ?? -1) >= savedMoves.length) {
        nextPossibleMoves.removeAt(i);
        i--;
        state.undo();
      } else {
        break;
      }
    }
    if (nextPossibleMoves.isEmpty) {
      final move = state.undo();
      if (move == null) return;
      final move2 = state.undo();
      if (move2 != null) {
        _loadNextPosition();
      }
    }
    ref.notifyListeners();
  }
}

abstract class MyTrainingNotifyer {
  Future<GuessResult?> onMove(squares.Move move, Duration animationDuration);
}

extension FenNormalized on bishop.Game {
  String get fenNormalized {
    return fen.split(' ').take(4).join(' ');
  }
}
