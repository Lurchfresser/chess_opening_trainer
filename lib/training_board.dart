import 'package:bishop/bishop.dart' as bishop;
import 'package:chess_opening_trainer/history_widet.dart';
import 'package:chess_opening_trainer/models.dart';
import 'package:chess_opening_trainer/opening_repo.dart';
import 'package:flutter/material.dart';
import 'package:square_bishop/square_bishop.dart';
import 'package:squares/squares.dart' as squares;

class TrainingBoard extends StatefulWidget {
  const TrainingBoard({super.key, required this.numberOfPositions});

  final int numberOfPositions;
  @override
  State<TrainingBoard> createState() => _TrainingBoardState();
}

class _TrainingBoardState extends State<TrainingBoard> {
  late bishop.Game game;
  late SquaresState state;
  int player = squares.Squares.white;
  bool fromWhitesPerpective = false;
  late ChessPosition chessPosition;
  final Duration animationDuration = const Duration(milliseconds: 250);
  late List<ChessPosition> positions;

  @override
  void initState() {
    //TODO: what if no position available
    positions = OpeningRepository.getMostDuePositions(
      numberOfPositions: widget.numberOfPositions,
      forWhite: fromWhitesPerpective,
    );
    _loadNextPosition();
    super.initState();
  }

  void _loadNextPosition() {
    if (positions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("No more positions available!"),
        ),
      );
      return;
    }
    chessPosition = positions.first;
    game = GameFromPosition.fromPosition(chessPosition);
    player = game.state.turn;
    state = game.squaresState(player);
  }

  void _flipBoard() => setState(() {
    fromWhitesPerpective = !fromWhitesPerpective;
    setState(_loadNextPosition);
  });

  void _onMove(squares.Move move) async {
    bool moveResult = game.makeSquaresMove(move);
    if (!moveResult) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Invalid move!"),
        ),
      );
      return;
    }
    final guessResult = OpeningRepository.updateMovePlayed(gameAfterMove: game);
    state = game.squaresState(player);
    setState(() {});

    final bool correct = guessResult != GuessResult.incorrect;

    ScaffoldMessenger.of(context).clearSnackBars();

    await Future.delayed(animationDuration);

    if (correct) {
      positions.removeAt(0);
      setState(_loadNextPosition);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.green, content: Text("Correct!")),
      );
    } else {
      await Future.delayed(Duration(milliseconds: 150));
      game.undo();
      player = game.state.turn;
      state = game.squaresState(player);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text("Incorrect!")),
      );
    }

    player = game.state.turn;
    state = game.squaresState(player);

    setState(() {});
  }

  void _undo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Debug feature!"),
      ),
    );
    if (game.history.length == 1) return;
    game.undo();
    setState(() {
      player =
          player == squares.Squares.white
              ? squares.Squares.black
              : squares.Squares.white;
      state = game.squaresState(player);
    });
  }

  @override
  Widget build(BuildContext context) {
    final possibleMoves = OpeningRepository.getRecommendedMoves(game.fen);

    return Scaffold(
      appBar: AppBar(title: const Text('Training Board')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Current Player: '),
                Text(
                  player == squares.Squares.white ? 'White' : 'Black',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                const Text('NUmber of positions remaining: '),
                Text(
                  positions.length.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Flexible(
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: squares.BoardController(
                    key: const Key("TrainingBoard"),
                    animationDuration: animationDuration,
                    animationCurve: Curves.linear,
                    animatePieces: true,
                    state:
                        ((state.player == squares.Squares.white) ==
                                fromWhitesPerpective)
                            ? state.board
                            : state.board.flipped(),
                    playState: state.state,
                    pieceSet: squares.PieceSet.merida(),
                    theme: squares.BoardTheme.brown,
                    moves: state.moves,
                    onMove: _onMove,
                    markerTheme: squares.MarkerTheme(
                      empty: squares.MarkerTheme.dot,
                      piece: squares.MarkerTheme.corners(),
                    ),
                    promotionBehaviour: squares.PromotionBehaviour.autoPremove,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _flipBoard,
                  icon: const Icon(Icons.rotate_left),
                ),
                IconButton(onPressed: _undo, icon: const Icon(Icons.undo)),
                IconButton(
                  onPressed: () => setState(_loadNextPosition),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            HistoryWidget(history: game.history),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: Row(
                children: [
                  SizedBox(height: 30),
                  for (var move in possibleMoves)
                    Text(
                      "${move.formatted}  ",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
