import 'package:flutter/material.dart';

class TrainingSessionDialog extends StatefulWidget {
  const TrainingSessionDialog({super.key});

  @override
  State<TrainingSessionDialog> createState() => _TrainingSessionDialogState();
}

class _TrainingSessionDialogState extends State<TrainingSessionDialog> {
  final TextEditingController _controller = TextEditingController(text: '10');
  bool forWhite = true;
  bool recursive = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Training Session'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          const Text('Number of positions:'),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter number of positions',
            ),
          ),
          const Text("play for white"),
          Switch(
            value: forWhite,
            onChanged:
                (_) => setState(() {
                  forWhite = !forWhite;
                }),
          ),
          Switch(
            value: recursive,
            onChanged:
                (_) => setState(() {
                  recursive = !recursive;
                }),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final int? numberOfPositions = int.tryParse(_controller.text);
            if (numberOfPositions == null || numberOfPositions <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a valid number')),
              );
              return;
            }
            // Start a new training session
            Navigator.of(context).pop(
              TrainingSessionConfig(
                numberOfPositions: numberOfPositions,
                forWhite: forWhite,
                recursive: recursive,
              ),
            );
          },
          child: const Text('Start'),
        ),
      ],
    );
  }
}

class TrainingSessionConfig {
  final int numberOfPositions;
  final bool forWhite;
  final bool recursive;

  TrainingSessionConfig({
    required this.numberOfPositions,
    required this.forWhite,
    required this.recursive,
  });
}
