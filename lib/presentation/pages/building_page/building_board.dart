import 'package:bishop/bishop.dart' as bishop;
import 'package:chess_opening_trainer/domain/building_notifier.dart';
import 'package:chess_opening_trainer/presentation/pages/building_page/widgets/possible_moves_widget.dart';
import 'package:chess_opening_trainer/presentation/widgets/history_widet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:square_bishop/square_bishop.dart';
import 'package:squares/squares.dart' as squares;

class BuildingBoard extends ConsumerStatefulWidget {
  final String repoName;
  const BuildingBoard({super.key, required this.repoName});
  @override
  ConsumerState<BuildingBoard> createState() => _BuildingBoardConsumerState();
}

class _BuildingBoardConsumerState extends ConsumerState<BuildingBoard> {
  late bishop.Game game;
  late SquaresState state;
  int player = squares.Squares.white;
  bool forWhite = true;

  @override
  void initState() {
    _resetGame(false);
    super.initState();
  }

  void _resetGame([bool ss = true]) {
    game = bishop.Game(variant: bishop.Variant.standard());
    state = game.squaresState(game.state.turn);
    player = game.state.turn;
    forWhite = true;
    if (ss) {
      setState(() {});
    }
  }

  void _flipBoard() => setState(() => forWhite = !forWhite);

  void _onMove(squares.Move move) {
    //TODO: Ask for safe if transposition is hit
    bool result = game.makeSquaresMove(move);
    if (result) {
      setState(() {
        player =
            player == squares.Squares.white
                ? squares.Squares.black
                : squares.Squares.white;
        state = game.squaresState(player);
      });
    }
  }

  void _undo() {
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
    final possibleMoves = ref.watch(
      savedMovesProvider(fen: game.fen, repoName: widget.repoName),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Building Board')),
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
                    key: const Key("BuildingBoard"),
                    animatePieces: false,
                    state:
                        ((state.player == squares.Squares.white) == forWhite)
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
                    ref.read(
                      addOpeningTillHereProvider.call(
                        game: game,
                        comment: "Test",
                        forWhite: forWhite,
                      ),
                    );
                  },
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
            HistoryWidget(history: game.history),
            if (possibleMoves.isNotEmpty)
              PossibleMovesWidget(
                possibleMoves: possibleMoves,
                onTap: (move) {
                  setState(() {
                    final legalMoves = game.generateLegalMoves();
                    for (var legalMove in legalMoves) {
                      if (move.algebraic ==
                          game.squaresMove(legalMove).algebraic()) {
                        game.makeMove(legalMove);
                        player =
                            player == squares.Squares.white
                                ? squares.Squares.black
                                : squares.Squares.white;
                        state = game.squaresState(player);
                        setState(() {});
                        return;
                      }
                    }
                    assert(
                      false,
                      "Move ${move.algebraic} not found in legal moves",
                    );
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
