import 'package:flutter/material.dart';
import '../widgets/sudoku_grid.dart';
import '../widgets/number_pad.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<List<int>> board = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9],
  ];

  int selectedRow = -1;
  int selectedCol = -1;

  late List<List<int>> initialBoard;
  late List<List<int>> solutionBoard;

  @override
  void initState() {
    super.initState();
    // Deep copy for initial state
    initialBoard = board.map((row) => List<int>.from(row)).toList();

    // Full solved version of the same puzzle
    solutionBoard = [
      [5, 3, 4, 6, 7, 8, 9, 1, 2],
      [6, 7, 2, 1, 9, 5, 3, 4, 8],
      [1, 9, 8, 3, 4, 2, 5, 6, 7],
      [8, 5, 9, 7, 6, 1, 4, 2, 3],
      [4, 2, 6, 8, 5, 3, 7, 9, 1],
      [7, 1, 3, 9, 2, 4, 8, 5, 6],
      [9, 6, 1, 5, 3, 7, 2, 8, 4],
      [2, 8, 7, 4, 1, 9, 6, 3, 5],
      [3, 4, 5, 2, 8, 6, 1, 7, 9],
    ];
  }

  void onNumberTap(int number) {
    if (selectedRow != -1 &&
        selectedCol != -1 &&
        initialBoard[selectedRow][selectedCol] == 0) {
      setState(() {
        board[selectedRow][selectedCol] = number;
      });

      if (isBoardCompleteAndCorrect()) {
        Future.delayed(const Duration(milliseconds: 200), () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Congratulations!"),
              content: const Text("You've completed the Sudoku puzzle! 🎉"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        });
      }
    }
  }


  void onTileTap(int row, int col) {
    setState(() {
      selectedRow = row;
      selectedCol = col;
    });
  }

  bool isBoardCompleteAndCorrect() {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col] != solutionBoard[row][col]) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sudoku Puzzle')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SudokuGrid(
            board: board,
            solutionBoard: solutionBoard,
            selectedRow: selectedRow,
            selectedCol: selectedCol,
            onTileTap: onTileTap,
          ),
          const SizedBox(height: 16),
          NumberPad(onNumberTap: onNumberTap),
        ],
      ),
    );
  }
}