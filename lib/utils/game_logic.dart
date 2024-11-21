import '../models/symbol.dart';
import '../models/cell.dart';



bool doesSymbolWin(Symbol a, Symbol b) {
  if (a == Symbol.rock && b == Symbol.scissors) return true;
  if (a == Symbol.paper && b == Symbol.rock) return true;
  if (a == Symbol.scissors && b == Symbol.paper) return true;
  return false;
}


bool canPlaceSymbol(List<List<Cell>> grid, int row, int col, Symbol symbol) {
  // Check if the cell is already occupied
  if (grid[row][col].symbol != null) return false;

  // Check row and column counts
  if (!hasMaxThreeSymbols(grid, row, symbol, isRow: true)) return false;
  if (!hasMaxThreeSymbols(grid, col, symbol, isRow: false)) return false;

  // Check for consecutive same symbols
  if (isConsecutiveSymbol(grid, row, col, symbol)) return false;

  // Additional rules for special symbols (=, X, <, >) can be added here

  return true;
}

bool hasMaxThreeSymbols(List<List<Cell>> grid, int index, Symbol symbol, {bool isRow = true}) {
  int count = 0;
  for (int i = 0; i < 9; i++) {
    Symbol? cellSymbol = isRow ? grid[index][i].symbol : grid[i][index].symbol;
    if (cellSymbol == symbol) {
      count++;
    }
  }
  return count < 3;
}




bool isConsecutiveSymbol(List<List<Cell>> grid, int row, int col, Symbol symbol) {
  List<Symbol?> adjacentSymbols = [];

  if (row > 0) adjacentSymbols.add(grid[row - 1][col].symbol);
  if (row < 8) adjacentSymbols.add(grid[row + 1][col].symbol);
  if (col > 0) adjacentSymbols.add(grid[row][col - 1].symbol);
  if (col < 8) adjacentSymbols.add(grid[row][col + 1].symbol);

  for (Symbol? adjSymbol in adjacentSymbols) {
    if (adjSymbol == symbol) return true;
  }
  return false;
}