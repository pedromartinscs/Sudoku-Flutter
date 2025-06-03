import 'dart:math';

Map<String, List<List<int>>> generateSudokuWithSolution({int emptyCells = 40}) {
  final full = List.generate(9, (_) => List.filled(9, 0));
  _fillBoard(full);

  final puzzle = full.map((row) => List<int>.from(row)).toList();
  _removeNumbers(puzzle, emptyCells);

  return {
    'solution': full,
    'puzzle': puzzle,
  };
}

List<List<int>> generateSudokuBoard({int emptyCells = 40}) {
  return generateSudokuWithSolution(emptyCells: emptyCells)['puzzle']!;
}

bool _isValid(List<List<int>> board, int row, int col, int num) {
  for (int i = 0; i < 9; i++) {
    if (board[row][i] == num || board[i][col] == num) return false;
  }
  int startRow = row - row % 3;
  int startCol = col - col % 3;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[startRow + i][startCol + j] == num) return false;
    }
  }
  return true;
}

bool _fillBoard(List<List<int>> board) {
  final rng = Random();
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      if (board[row][col] == 0) {
        final numbers = List.generate(9, (i) => i + 1)..shuffle(rng);
        for (final num in numbers) {
          if (_isValid(board, row, col, num)) {
            board[row][col] = num;
            if (_fillBoard(board)) return true;
            board[row][col] = 0;
          }
        }
        return false;
      }
    }
  }
  return true;
}

void _removeNumbers(List<List<int>> board, int count) {
  final rng = Random();
  int removed = 0;
  while (removed < count) {
    int row = rng.nextInt(9);
    int col = rng.nextInt(9);
    if (board[row][col] != 0) {
      board[row][col] = 0;
      removed++;
    }
  }
}