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
  Future<bool> onMove(squares.Move move, Duration animationDuration) async {
    if (_positions.isEmpty) {
      return false;
    }
    final fenBefore = state.fen;
    bool moveResult = state.makeSquaresMove(move);
    if (!moveResult) {
      return false;
    }
    final guessResult = ref.read(
      guessProvider(
        fen: fenBefore,
        algebraic: state.history.last.meta!.algebraic!,
      ),
    );

    final bool correct = guessResult != GuessResult.incorrect;

    await Future.delayed(animationDuration);

    if (correct) {
      _positions.removeAt(0);
      _loadNextPosition();
      return true;
    } else {
      await Future.delayed(Duration(milliseconds: 150));
      state.undo();
      return false;
    }
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
  final List<String> _visitedPositions = [];
  @override
  bishop.Game build(bool forWhite, int numberOfPositions) {
    return bishop.Game();
  }

  @override
  //returns the success of the move
  Future<bool> onMove(squares.Move move, Duration animationDuration) async {
    final fenBefore = state.fen;
    bool moveResult = state.makeSquaresMove(move);
    if (!moveResult) {
      return false;
    }
    final guessResult = ref.read(
      guessProvider(
        fen: fenBefore,
        algebraic: state.history.last.meta!.algebraic!,
      ),
    );

    final bool correct = guessResult != GuessResult.incorrect;

    await Future.delayed(animationDuration);

    if (correct) {
      _visitedPositions.add(fenBefore);
      _loadNextPosition();
      return true;
    } else {
      await Future.delayed(Duration(milliseconds: 150));
      state.undo();
      return false;
    }
  }

  void _loadNextPosition() {
    final nextPossibleMoves = state.generateLegalMoves();
    for (var i = 0; i < nextPossibleMoves.length; i++) {
      final move = nextPossibleMoves[i];
      state.makeMove(move);
      final moveInRepo =
          ref.read(savedMovesProvider(fen: state.fen)).isNotEmpty;
      if (!moveInRepo || _visitedPositions.contains(state.fen)) {
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
  Future<bool> onMove(squares.Move move, Duration animationDuration);
}
