import 'dart:async';

import 'package:bishop/bishop.dart';
import 'package:chess_opening_trainer/dependencies.dart';
import 'package:chess_opening_trainer/infrastructure/datasources/opening_repo.dart';
import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'building_notifier.g.dart';

@riverpod
GuessResult guess(Ref ref, {required String fen, required String algebraic}) {
  final OpeningRepository repo = sl<OpeningRepository>();
  final result = repo.addGuess(fen: fen, algebraic: algebraic);
  ref.invalidateSelf();
  return result;
}

@riverpod
void addOpeningTillHere(
  Ref ref, {
  required Game game,
  required String comment,
  required bool forWhite,
}) {
  final repo = sl<OpeningRepository>();
  unawaited(
    repo
        .addOpeningTillHere(game: game, comment: comment, forWhite: forWhite)
        .then((value) {
          ref.invalidateSelf();
          ref.invalidate(savedMovesProvider);
          ref.invalidate(duePositionsProvider);
          ref.invalidate(guessProvider);
        }),
  );
}

@riverpod
List<ChessPosition> duePositions(
  Ref ref, {
  required int numberOfPositions,
  required bool forWhite,
}) {
  final OpeningRepository repo = sl();
  return repo.getMostDuePositions(
    numberOfPositions: numberOfPositions,
    forWhite: forWhite,
  );
}

@riverpod
List<PositionMove> savedMoves(Ref ref, {required String fen}) {
  final OpeningRepository repo = sl();
  fen = repo.normalizeFen(fen);

  return repo.getRecommendedMoves(fen);
}
