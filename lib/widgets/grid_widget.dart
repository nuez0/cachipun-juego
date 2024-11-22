import 'package:flutter/material.dart';
import 'dart:math';
import '../models/cell.dart';
import 'cell_widget.dart';
import 'divider_widget.dart';

class GridWidget extends StatelessWidget {
  final List<List<Cell>> grid; // Matriz de 9x9
  final Function(int, int) onCellTap;

  // Los símbolos posibles
  final List<String> symbols = ['=', '<', '>'];

  late final List<Map<String, dynamic>> dividerSymbols;

  GridWidget({
    required this.grid,
    required this.onCellTap,
  }) {
    dividerSymbols = _generateRandomSymbols(grid.length);
  }

  @override
  Widget build(BuildContext context) {
    // Tamaño disponible para calcular celdas
    final double screenWidth = MediaQuery.of(context).size.width * 0.9; // 90% del ancho
    final double screenHeight = MediaQuery.of(context).size.height * 0.7; // 70% del alto
    final double gridSize = min(screenWidth, screenHeight); // Usar el más pequeño
    final double spacing = 2.0; // Espaciado uniforme entre celdas
    final double totalSpacing = (grid[0].length - 1) * spacing; // Espacio total entre celdas
    final double cellSize = max((gridSize - totalSpacing) / grid[0].length, 24.0); // Tamaño mínimo de 24px

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.all(spacing), // Margen exterior
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(grid.length * 2 - 1, (rowIndex) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(grid[0].length * 2 - 1, (colIndex) {
                      if (rowIndex % 2 == 0 && colIndex % 2 == 0) {
                        // Es una celda
                        int gridRowIndex = rowIndex ~/ 2;
                        int gridColIndex = colIndex ~/ 2;
                        return Container(
                          width: cellSize,
                          height: cellSize,
                          margin: EdgeInsets.all(spacing / 2), // Márgenes uniformes
                          decoration: BoxDecoration(
                            color: (gridRowIndex + gridColIndex) % 2 == 0
                                ? Colors.grey[200]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: CellWidget(
                            cell: grid[gridRowIndex][gridColIndex], onTap: () {  },
                          ),
                        );
                      } else if (rowIndex % 2 != 0 || colIndex % 2 != 0) {
                        // Es un divisor
                        return Container(
                          width: (colIndex % 2 == 0) ? cellSize : spacing,
                          height: (rowIndex % 2 == 0) ? cellSize : spacing,
                          color: Colors.grey[300],
                        );
                      } else {
                        return SizedBox(width: spacing, height: spacing);
                      }
                    }),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Generar símbolos aleatorios
  List<Map<String, dynamic>> _generateRandomSymbols(int gridSize) {
    final random = Random();
    final List<Map<String, dynamic>> symbolsList = [];
    final totalDividers = (gridSize - 1) * 2 * gridSize;

    for (int i = 0; i < totalDividers / 4; i++) {
      int rowIndex = random.nextInt(gridSize * 2 - 1);
      int colIndex = random.nextInt(gridSize * 2 - 1);

      if ((rowIndex % 2 == 0 && colIndex % 2 != 0) || (rowIndex % 2 != 0 && colIndex % 2 == 0)) {
        symbolsList.add({
          'row': rowIndex,
          'col': colIndex,
          'symbol': symbols[random.nextInt(symbols.length)],
        });
      }
    }

    return symbolsList;
  }
}
