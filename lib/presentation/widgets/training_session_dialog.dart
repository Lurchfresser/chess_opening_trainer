import 'package:flutter/material.dart';

class TrainingSessionDialog extends StatefulWidget {
  const TrainingSessionDialog({super.key});

  @override
  State<TrainingSessionDialog> createState() => _TrainingSessionDialogState();
}

class _TrainingSessionDialogState extends State<TrainingSessionDialog> {
  final TextEditingController _controller = TextEditingController();

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
            Navigator.of(context).pop(numberOfPositions);
          },
          child: const Text('Start'),
        ),
      ],
    );
  }
}
