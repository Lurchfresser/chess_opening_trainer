import 'package:bishop/bishop.dart' as bishop;
import 'package:chess_opening_trainer/opening_repo.dart';
import 'package:flutter/material.dart';
import 'package:square_bishop/square_bishop.dart';
import 'package:squares/squares.dart';

class ChessBoard extends StatefulWidget {
  const ChessBoard({super.key});
  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  late bishop.Game game;
  late SquaresState state;
  int player = Squares.white;
  bool flipBoard = false;

  @override
  void initState() {
    _resetGame(false);
    super.initState();
  }

  void _resetGame([bool ss = true]) {
    game = bishop.Game(variant: bishop.Variant.standard());
    state = game.squaresState(player);
    player = Squares.white;
    if (ss) setState(() {});
  }

  void _flipBoard() => setState(() => flipBoard = !flipBoard);

  void _onMove(Move move) async {
    bool result = game.makeSquaresMove(move);
    if (result) {
      flipBoard = !flipBoard;
      setState(() {
        player = player == Squares.white ? Squares.black : Squares.white;
        state = game.squaresState(player);
      });
    }
  }

  void _undo() {
    game.undo();
    flipBoard = !flipBoard;
    setState(() {
      player = player == Squares.white ? Squares.black : Squares.white;
      state = game.squaresState(player);
    });
  }

  @override
  Widget build(BuildContext context) {
    final possibleMoves = OpeningRepository.getRecommendedMoves(game.fen);

    return Scaffold(
      appBar: AppBar(title: const Text('Squares Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: BoardController(
                    animatePieces: false,
                    state: flipBoard ? state.board.flipped() : state.board,
                    playState: state.state,
                    pieceSet: PieceSet.merida(),
                    theme: BoardTheme.brown,
                    moves: state.moves,
                    onMove: _onMove,
                    markerTheme: MarkerTheme(
                      empty: MarkerTheme.dot,
                      piece: MarkerTheme.corners(),
                    ),
                    promotionBehaviour: PromotionBehaviour.autoPremove,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
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
                    OpeningRepository.addMove(
                      game.fen,
                      game.history.last.meta!.algebraic!,
                      game.fen,
                      isMainLine: true,
                      comment: "Test",
                    );
                  },
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(height: 50),
                ...game.history.map((move) {
                  //remove the 0th move
                  if (move.meta?.moveMeta?.formatted == null) {
                    return const SizedBox();
                  }
                  return Text(
                    "${move.meta?.moveMeta?.formatted ?? "null"}   ",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  );
                }),
              ],
            ),
            Row(
              children: [
                const Text('Current Player: '),
                Text(
                  player == Squares.white ? 'White' : 'Black',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                for (var move in possibleMoves)
                  Text(
                    "${move.algebraic}  ",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
