import 'package:flutter/material.dart';
import '../models/cell.dart';
import '../widgets/grid_widget.dart';
import '../widgets/symbol_selector.dart';
import '../utils/game_logic.dart';
import '../models/symbol.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<Cell>> grid;
List<Map<String, dynamic>> dividerSymbols = [
  {'row': 0, 'col': 1, 'symbol': '='},
  {'row': 1, 'col': 0, 'symbol': '>'},
  {'row': 1, 'col': 2, 'symbol': '<'},
];


  @override
  void initState() {
    super.initState();
    initializeGrid();
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

  void initializeGrid() {
    // Inicializar la matriz vacía
    grid = List.generate(9, (row) => List.generate(9, (col) => Cell()));

    // Lista de símbolos que queremos distribuir aleatoriamente
    List<String> symbols = ['===', '===', 'X', 'X', '<', '<', '>', '>'];

    // Barajar los símbolos aleatoriamente
    symbols.shuffle(Random());

    // Generar posiciones aleatorias para los divisores
    for (String symbol in symbols) {
      bool placed = false;
      while (!placed) {
        int randomRow =
            Random().nextInt(17); // Hay 17 filas posibles en la cuadrícula
        int randomCol =
            Random().nextInt(17); // Hay 17 columnas posibles en la cuadrícula

        // Solo permitir divisores (líneas) como posiciones válidas
        if (randomRow % 2 == 1 || randomCol % 2 == 1) {
          if (!dividerSymbols
              .any((s) => s['row'] == randomRow && s['col'] == randomCol)) {
            dividerSymbols
                .add({'row': randomRow, 'col': randomCol, 'symbol': symbol});
            placed = true;
          }
        }
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
