import 'package:bishop/bishop.dart';
import 'package:chess_opening_trainer/domain/building_notifier.dart';
import 'package:chess_opening_trainer/domain/training_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:square_bishop/square_bishop.dart';
import 'package:squares/squares.dart' as squares;

class TrainingBoard extends ConsumerStatefulWidget {
  const TrainingBoard({
    required this.forWhite,
    required this.numberOfPositions,
    required this.recursive,
    super.key,
  });
  final bool forWhite;
  final bool recursive;
  final int numberOfPositions;

  @override
  ConsumerState<TrainingBoard> createState() => _TrainingBoardConsumerState();
}

class _TrainingBoardConsumerState extends ConsumerState<TrainingBoard> {
  // late bishop.Game game;
  // late SquaresState state;
  // int player = squares.Squares.white;
  // late ChessPosition chessPosition;
  final Duration animationDuration = const Duration(milliseconds: 250);
  // late List<ChessPosition> positions;

  @override
  void initState() {
    // positions = ref.read(
    //   duePositionsProvider.call(
    //     forWhite: widget.forWhite,
    //     numberOfPositions: widget.numberOfPositions,
    //   ),
    // );
    // _loadNextPosition();
    super.initState();
  }

  // void _loadNextPosition() {
  //   if (positions.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text("No more positions available!"),
  //       ),
  //     );
  //     return;
  //   }
  //   chessPosition = positions.first;
  //   game = GameFromPosition.fromPosition(chessPosition);
  //   player = game.state.turn;
  //   state = game.squaresState(player);
  // }

  // Future<void> _onMove(squares.Move move) async {
  //   if (positions.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text("No more positions available!"),
  //       ),
  //     );
  //     return;
  //   }
  //   final fenBefore = game.fen;
  //   bool moveResult = game.makeSquaresMove(move);
  //   if (!moveResult) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text("Invalid move!"),
  //       ),
  //     );
  //     return;
  //   }
  //   state = game.squaresState(player);
  //   final guessResult = ref.read(
  //     guessProvider(
  //       fen: fenBefore,
  //       algebraic: game.history.last.meta!.algebraic!,
  //     ),
  //   );

  //   final bool correct = guessResult != GuessResult.incorrect;

  //   ScaffoldMessenger.of(context).clearSnackBars();

  //   await Future.delayed(animationDuration);

  //   if (correct) {
  //     positions.removeAt(0);
  //     setState(_loadNextPosition);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(backgroundColor: Colors.green, content: Text("Correct!")),
  //     );
  //   } else {
  //     await Future.delayed(Duration(milliseconds: 150));
  //     game.undo();
  //     player = game.state.turn;
  //     state = game.squaresState(player);
  //     setState(() {});
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(backgroundColor: Colors.red, content: Text("Incorrect!")),
  //     );
  //   }

  //   player = game.state.turn;
  //   state = game.squaresState(player);

  //   setState(() {});
  // }

  // void _undo() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       backgroundColor: Colors.red,
  //       content: Text("Debug feature!"),
  //     ),
  //   );
  //   if (game.history.length == 1) return;
  //   game.undo();
  //   setState(() {
  //     player =
  //         player == squares.Squares.white
  //             ? squares.Squares.black
  //             : squares.Squares.white;
  //     state = game.squaresState(player);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider =
        widget.recursive
            ? recursiveTrainingSessionManagerProvider(
              widget.forWhite,
              widget.numberOfPositions,
            )
            : randomTrainingSessionManagerProvider(
              widget.forWhite,
              widget.numberOfPositions,
            );
    final game = ref.watch(provider);
    final state = game.squaresState(
      widget.forWhite ? squares.Squares.white : squares.Squares.black,
    );
    final possibleMoves = ref.watch(savedMovesProvider(fen: game.fen));

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
                  widget.forWhite ? 'White' : 'Black',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                const Text('NUmber of positions remaining: '),
                Text(
                  "positions.length.toString(),",
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
                                widget.forWhite)
                            ? state.board
                            : state.board.flipped(),
                    playState: state.state,
                    pieceSet: squares.PieceSet.merida(),
                    theme: squares.BoardTheme.brown,
                    moves: state.moves,
                    onMove:
                    // ignore: unnecessary_async
                    (move) async {
                      bool correct = await (ref.read(
                                widget.recursive
                                    ? recursiveTrainingSessionManagerProvider(
                                      widget.forWhite,
                                      widget.numberOfPositions,
                                    ).notifier
                                    : randomTrainingSessionManagerProvider(
                                      widget.forWhite,
                                      widget.numberOfPositions,
                                    ).notifier,
                              )
                              as MyTrainingNotifyer)
                          .onMove(move, animationDuration);
                      if (!mounted) return;
                      if (correct) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Correct!"),
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Incorrect!"),
                          ),
                        );
                      }
                    },
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
                // IconButton(onPressed: _undo, icon: const Icon(Icons.undo)),
                // IconButton(
                //   onPressed: () => setState(_loadNextPosition),
                //   icon: const Icon(Icons.refresh),
                // ),
              ],
            ),
            // HistoryWidget(history: game.history),
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
