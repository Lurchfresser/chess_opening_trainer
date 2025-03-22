import 'package:bishop/bishop.dart';
import 'package:chess_opening_trainer/dependencies.dart';
import 'package:chess_opening_trainer/infrastructure/datasources/opening_repo.dart';
import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'building_notifier.g.dart';

@riverpod
class ReportoirNotifier extends _$ReportoirNotifier {
  late final OpeningRepository _repo;

  @override
  List<PositionMove> build() {
    _repo = sl<OpeningRepository>();
    return [];
  }

  //TODO: this architecture is not good, we need to refactor this
  void updatePosition(Game game) {
    state = _repo.getRecommendedMoves(game.fen);
  }

  void addLastMove({required Game game, required String comment}) {
    _repo.addLastMove(game: game, comment: comment);
    ref.invalidateSelf();
  }

  GuessResult addGuess({required String fen, required String algebraic}) {
    ref.invalidateSelf();
    return _repo.addGuess(fen: fen, algebraic: algebraic);
  }
}
