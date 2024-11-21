import 'package:flutter/material.dart';
import '../models/cell.dart';
import '../models/symbol.dart';
import '../utils/game_logic.dart';

class GameProvider with ChangeNotifier {
  late List<List<Cell>> grid;

  GameProvider() {
    resetGame();
  }

  void resetGame() {
    grid = List.generate(9, (row) => List.generate(9, (col) => Cell()));
    notifyListeners();
  }

  bool placeSymbol(int row, int col, Symbol symbol) {
    if (canPlaceSymbol(grid, row, col, symbol)) {
      grid[row][col].symbol = symbol;
      notifyListeners();
      return true;
    }
    return false;
  }
}
