import 'package:chess_opening_trainer/infrastructure/models/models.dart';
import 'package:flutter/material.dart';

class PossibleMovesWidget extends StatelessWidget {
  const PossibleMovesWidget({
    super.key,
    required this.possibleMoves,
    required this.onTap,
  });

  final List<PositionMove> possibleMoves;
  final void Function(PositionMove move) onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: Row(
        children: [
          for (var move in possibleMoves)
            GestureDetector(
              onTap: () {
                onTap(move);
              },
              child: Text(
                "${move.formatted}  ",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
