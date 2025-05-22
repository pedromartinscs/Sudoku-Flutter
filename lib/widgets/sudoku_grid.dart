import 'package:flutter/material.dart';

class SudokuGrid extends StatelessWidget {
  final List<List<int>> board;
  final List<List<int>> solutionBoard;
  final int selectedRow;
  final int selectedCol;
  final Function(int, int) onTileTap;

  const SudokuGrid({
    super.key,
    required this.board,
    required this.solutionBoard,
    required this.selectedRow,
    required this.selectedCol,
    required this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Column(
          children: List.generate(9, (row) {
            return Expanded(
              child: Row(
                children: List.generate(9, (col) {
                  final value = board[row][col];
                  final isSelected = row == selectedRow && col == selectedCol;
                  final isWrong = value != 0 && value != solutionBoard[row][col];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTileTap(row, col),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.amber.shade200 : Colors.white,
                          border: Border(
                            top: BorderSide(
                                color: row % 3 == 0 ? Colors.black : Colors.grey, width: 1),
                            left: BorderSide(
                                color: col % 3 == 0 ? Colors.black : Colors.grey, width: 1),
                            right: BorderSide(
                                color: col == 8 ? Colors.black : Colors.grey, width: 1),
                            bottom: BorderSide(
                                color: row == 8 ? Colors.black : Colors.grey, width: 1),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          value != 0 ? value.toString() : '',
                          style: TextStyle(
                            fontSize: 18,
                            color: isWrong ? Colors.red : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }
}
