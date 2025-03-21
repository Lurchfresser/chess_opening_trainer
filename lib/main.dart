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

  //clear box for debugging
  await Hive.deleteBoxFromDisk('positions');

  // Open the box
  await Hive.openBox<ChessPosition>('positions');

  runApp(ProviderScope(child: const App()));
}
