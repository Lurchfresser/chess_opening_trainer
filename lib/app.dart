import 'package:chess_opening_trainer/building_board.dart';
import 'package:chess_opening_trainer/training_board.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;
  final List<Widget> pages = [const BuildingBoard(), const TrainingBoard()];

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
                        index = 0;
                      });
                      // Add navigation to building screen
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text('Train Openings'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        index = 1;
                      });
                      // Add navigation to training screen
                    },
                  ),
                ],
              ),
            );
          },
        ),
        body: pages[index],
      ),
    );
  }
}
