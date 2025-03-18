import 'package:bishop/bishop.dart' as bishop;
import 'package:chess_opening_trainer/history_widet.dart';
import 'package:chess_opening_trainer/models.dart';
import 'package:chess_opening_trainer/opening_repo.dart';
import 'package:flutter/material.dart';
import 'package:square_bishop/square_bishop.dart';
import 'package:squares/squares.dart' as squares;

class TrainingBoard extends StatefulWidget {
  const TrainingBoard({super.key});
  @override
  State<TrainingBoard> createState() => _TrainingBoardState();
}

class _TrainingBoardState extends State<TrainingBoard> {
  late bishop.Game game;
  late SquaresState state;
  int player = squares.Squares.white;
  bool flipBoard = false;
  var gameAndMOve = OpeningRepository.getRandomMove();

  @override
  void initState() {
    game = GameFromPosition.fromPosition(gameAndMOve.$1);
    player = game.state.turn;
    state = game.squaresState(player);
    super.initState();
  }

  void _resetGame([bool ss = true]) {
    game = bishop.Game(variant: bishop.Variant.standard());
    state = game.squaresState(player);
    player = squares.Squares.white;
    if (ss) setState(() {});
  }

  void _flipBoard() => setState(() => flipBoard = !flipBoard);

  void _onMove(squares.Move move) async {
    bool result = game.makeSquaresMove(move);
    if (result) {
      flipBoard = !flipBoard;

      final bool correct = gameAndMOve.$1.nextMoves.containsKey(
        move.algebraic(),
      );

      if (correct) {
        gameAndMOve = OpeningRepository.getRandomMove();
        game = GameFromPosition.fromPosition(gameAndMOve.$1);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.green, content: Text("Correct!")),
        );
      } else {
        game.undo();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text("Incorrect!")),
        );
      }

      player = game.state.turn;
      state = game.squaresState(player);

      setState(() {});
    }
  }

  void _undo() {
    if (game.history.length == 1) return;
    game.undo();
    flipBoard = !flipBoard;
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
            Flexible(
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: squares.BoardController(
                    animatePieces: false,
                    state: flipBoard ? state.board.flipped() : state.board,
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
                OutlinedButton(
                  onPressed: _resetGame,
                  child: const Text('New Game'),
                ),
                IconButton(
                  onPressed: _flipBoard,
                  icon: const Icon(Icons.rotate_left),
                ),
                IconButton(onPressed: _undo, icon: const Icon(Icons.undo)),
                IconButton(
                  onPressed: () {
                    if (game.history.length == 1) return;
                    final move = game.undo();
                    final fen = game.fen;
                    game.makeMove(move!);
                    OpeningRepository.addMove(
                      fromFen: fen,
                      algebraic: game.history.last.meta!.algebraic!,
                      formatted: game.history.last.meta!.prettyName!,
                      toFen: game.fen,
                      isMainLine: true,
                      comment: "Test",
                    );
                  },
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
            HistoryWidget(history: game.history),
            if (possibleMoves.isNotEmpty)
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                ),
                child: Row(
                  children: [
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
