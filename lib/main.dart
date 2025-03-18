import 'package:chess_opening_trainer/chess_board.dart';
import 'package:chess_opening_trainer/models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  // Register adapters
  Hive.registerAdapter(ChessPositionAdapter());
  Hive.registerAdapter(PositionMoveAdapter());

  // Open the box
  await Hive.openBox<ChessPosition>('positions');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squares Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ChessBoard(),
    );
  }
}
