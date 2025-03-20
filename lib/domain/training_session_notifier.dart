import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'training_session_notifier.g.dart';

@riverpod
class TrainingSessionNotifier extends _$TrainingSessionNotifier {
  @override
  List<ChessPosition> build() {
    return [];
  }
}
