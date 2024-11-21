import 'package:flutter/material.dart';
import '../models/cell.dart';
import '../widgets/grid_widget.dart';
import '../widgets/symbol_selector.dart';
import '../utils/game_logic.dart';
import '../models/symbol.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<Cell>> grid;

  @override
  void initState() {
    super.initState();
    // Initialize the grid with empty cells
    grid = List.generate(9, (row) => List.generate(9, (col) => Cell()));
  }

  void onCellTap(int row, int col) async {
    // Open symbol selector when a cell is tapped
    Symbol? selectedSymbol = await showModalBottomSheet<Symbol>(
      context: context,
      builder: (context) => Container(
        height: 200,
        child: SymbolSelector(
          onSymbolSelected: (symbol) {
            Navigator.pop(context, symbol);
          },
        ),
      ),
    );

    if (selectedSymbol != null) {
      // Validate the placement
      if (canPlaceSymbol(grid, row, col, selectedSymbol)) {
        setState(() {
          grid[row][col].symbol = selectedSymbol;
        });
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cannot place symbol here')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rock-Paper-Scissors Grid Game'),
      ),
      body: GridWidget(
        grid: grid,
        onCellTap: onCellTap,
      ),
    );
  }
}
