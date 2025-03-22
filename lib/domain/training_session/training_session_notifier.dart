import 'package:chess_opening_trainer/dependencies.dart';
import 'package:chess_opening_trainer/infrastructure/datasources/opening_repo.dart';
import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'training_session_notifier.g.dart';

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
  assert(
    fen.split(" ").length == 4,
    "number of moves must be removed from String",
  );

  return repo.getRecommendedMoves(fen);
}
