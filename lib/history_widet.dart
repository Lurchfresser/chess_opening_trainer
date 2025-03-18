import 'package:bishop/bishop.dart' as bishop;
import 'package:flutter/material.dart';
import 'package:squares/squares.dart' as squares;

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key, required this.history});

  final List<bishop.BishopState> history;

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HistoryWidget oldWidget) {
    if (oldWidget != widget) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...widget.history.map((move) {
            //remove the 0th move
            if (move.move == null) return const SizedBox.shrink();
            return MoveButton(move: move);
          }),
        ],
      ),
    );
  }
}

class MoveButton extends StatelessWidget {
  const MoveButton({super.key, required this.move});

  final bishop.BishopState move;

  @override
  Widget build(BuildContext context) {
    bool isWhite = move.turn == squares.Squares.black;

    return Text(
      "${isWhite ? ("${move.fullMoves}.") : ''}${move.meta!.prettyName!}${isWhite ? ' ' : "     "}",
      textAlign: TextAlign.left,
      style: const TextStyle(fontSize: 16),
    );
  }
}
