import 'package:flutter/material.dart';
import '../models/cell.dart';
import '../models/symbol.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;
  final VoidCallback onTap;

  CellWidget({required this.cell, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String displaySymbol;
    // Map the Symbol enum to displayable characters or icons
    switch (cell.symbol) {
      case Symbol.rock:
        displaySymbol = '🪨';
        break;
      case Symbol.paper:
        displaySymbol = '📄';
        break;
      case Symbol.scissors:
        displaySymbol = '✂️';
        break;
      case Symbol.equal:
        displaySymbol = '=';
        break;
      case Symbol.different:
        displaySymbol = 'X';
        break;
      case Symbol.winsRight:
        displaySymbol = '<';
        break;
      case Symbol.winsLeft:
        displaySymbol = '>';
        break;
      default:
        displaySymbol = '';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            displaySymbol,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
