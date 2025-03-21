import 'package:bishop/bishop.dart';
import 'package:chess_opening_trainer/dependencies.dart';
import 'package:chess_opening_trainer/infrastructure/datasources/opening_repo.dart';
import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'training_session_notifier.g.dart';

@Riverpod(keepAlive: true)
class TrainingSessionNotifier extends _$TrainingSessionNotifier {
  late final OpeningRepository _openingRepository;

  @override
  List<ChessPosition> build() {
    _openingRepository = sl<OpeningRepository>();
    return [];
  }

  void startSession({required bool forWhite, required int numberOfPositions}) {
    state = _openingRepository.getMostDuePositions(
      numberOfPositions: numberOfPositions,
      forWhite: forWhite,
    );
    debugPrint("Starting session with ${state.length} positions");
  }

  GuessResult updateMovePlayed({required Game gameAfterMove}) {
    //TODO: get the function to here
    return _openingRepository.updateMovePlayed(gameAfterMove: gameAfterMove);
  }

  List<PositionMove> getRecommendedMoves(String fen) {
    //TODO: remove the fen passed, use the function entirely here or define custom class or dependent provider to provide the moves
    return _openingRepository.getRecommendedMoves(fen);
  }
}
