import 'package:chess_opening_trainer/infrastructure/datasources/opening_repo.dart';
import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Register adapters
  Hive.registerAdapter(ChessPositionAdapter());
  Hive.registerAdapter(PositionMoveAdapter());
  Hive.registerAdapter(GameHistoryAdapter());
  Hive.registerAdapter(GuessEntryAdapter());
  Hive.registerAdapter(GuessResultAdapter());

  final repos = ["black", "white"];
  for (var repoName in repos) {
    sl.registerLazySingleton<OpeningRepository>(
      () => OpeningRepository(repoName: repoName),
      instanceName: repoName,
    );
  }
}
