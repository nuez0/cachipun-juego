import 'package:flutter/material.dart';
import '../models/cell.dart';
import 'cell_widget.dart';

class GridWidget extends StatelessWidget {
  final List<List<Cell>> grid;
  final Function(int, int) onCellTap;

  GridWidget({required this.grid, required this.onCellTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 81, // 9x9 grid
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 9,
      ),
      itemBuilder: (context, index) {
        int row = index ~/ 9;
        int col = index % 9;
        return CellWidget(
          cell: grid[row][col],
          onTap: () => onCellTap(row, col),
        );
      },
    );
  }
}
