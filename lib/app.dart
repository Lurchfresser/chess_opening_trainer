import 'package:chess_opening_trainer/presentation/pages/building_page/building_board.dart';
import 'package:chess_opening_trainer/presentation/pages/training_page/training_board.dart';
import 'package:chess_opening_trainer/presentation/widgets/training_session_dialog.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Widget currentPage = const BuildingBoard();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess Opening Trainer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Chess Opening Trainer')),
        drawer: Builder(
          builder: (context) {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Text(
                      'Chess Opening Trainer',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Create Opening'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currentPage = const BuildingBoard();
                      });
                      // Add navigation to building screen
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text('Train Openings'),
                    onTap: () async {
                      Navigator.pop(context);
                      final numberOfPositions = await showDialog<int?>(
                        context: context,
                        builder: (context) => const TrainingSessionDialog(),
                      );
                      if (numberOfPositions == null) return;
                      setState(() {
                        currentPage = TrainingBoard(
                          numberOfPositions: numberOfPositions,
                        );
                      });
                      // Add navigation to training screen
                    },
                  ),
                ],
              ),
            );
          },
        ),
        body: currentPage,
      ),
    );
  }
}
