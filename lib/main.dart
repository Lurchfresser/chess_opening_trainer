import 'package:chess_opening_trainer/app.dart';
import 'package:chess_opening_trainer/dependencies.dart';
import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDir = await path_provider.getApplicationSupportDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  await initDependencies();

  //clear boxes for debugging
  await Hive.deleteBoxFromDisk('white');
  await Hive.deleteBoxFromDisk('black');

  await Hive.openBox<ChessPosition>('white');
  await Hive.openBox<ChessPosition>('black');

  runApp(ProviderScope(child: const App()));
}
