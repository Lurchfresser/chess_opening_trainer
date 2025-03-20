import 'package:chess_opening_trainer/app.dart';
import 'package:chess_opening_trainer/models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDir = await path_provider.getApplicationSupportDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  // Register adapters
  Hive.registerAdapter(ChessPositionAdapter());
  Hive.registerAdapter(PositionMoveAdapter());
  Hive.registerAdapter(GameHistoryAdapter());
  Hive.registerAdapter(GuessEntryAdapter());
  Hive.registerAdapter(GuessResultAdapter());

  //clear box for debugging
  await Hive.deleteBoxFromDisk('positions');

  // Open the box
  await Hive.openBox<ChessPosition>('positions');

  runApp(const App());
}
