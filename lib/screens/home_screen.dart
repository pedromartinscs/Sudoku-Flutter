import 'package:flutter/material.dart';
import '../widgets/sudoku_grid.dart';
import '../widgets/number_pad.dart';
import '../models/sudoku_board.dart' show generateSudokuWithSolution;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<List<int>> board;
  late List<List<int>> initialBoard;
  late List<List<int>> solutionBoard;

  int selectedRow = -1;
  int selectedCol = -1;

  @override
  void initState() {
    super.initState();
    _generateNewPuzzle();
  }

  void _generateNewPuzzle() {
    final result = generateSudokuWithSolution();
    board = result['puzzle']!;
    solutionBoard = result['solution']!;
    initialBoard = board.map((row) => List<int>.from(row)).toList();
    selectedRow = -1;
    selectedCol = -1;
  }

  void onNumberTap(int number) {
    if (selectedRow != -1 &&
        selectedCol != -1 &&
        initialBoard[selectedRow][selectedCol] == 0) {
      setState(() {
        // Clear all incorrect guesses before adding the new number
        for (int r = 0; r < 9; r++) {
          for (int c = 0; c < 9; c++) {
            if (initialBoard[r][c] == 0 &&
                board[r][c] != 0 &&
                board[r][c] != solutionBoard[r][c]) {
              board[r][c] = 0;
            }
          }
        }

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
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _generateNewPuzzle();
                    });
                  },
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

  void resetBoard() {
    setState(() {
      board = initialBoard.map((row) => List<int>.from(row)).toList();
      selectedRow = -1;
      selectedCol = -1;
    });
  }

  Set<int> getUsedUpNumbers() {
    Map<int, int> count = {};
    for (var row in board) {
      for (var val in row) {
        if (val != 0) {
          count[val] = (count[val] ?? 0) + 1;
        }
      }
    }
    return count.entries.where((e) => e.value >= 9).map((e) => e.key).toSet();
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
      body: SingleChildScrollView(
        child: Column(
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
            NumberPad(
              onNumberTap: onNumberTap,
              usedNumbers: getUsedUpNumbers(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: resetBoard,
              child: const Text('Reset Puzzle'),
            ),
          ],
        ),
      ),
    );
  }
}
