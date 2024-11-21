import 'package:flutter/material.dart';
import '../models/cell.dart';
import '../models/symbol.dart';

class CellWidget extends StatefulWidget {
  final Cell cell;
  final VoidCallback onTap;

  CellWidget({required this.cell, required this.onTap});

  @override
  _CellWidgetState createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    String displaySymbol;
    // Mapear el símbolo al carácter o icono correspondiente
    switch (widget.cell.symbol) {
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

    // Determinar el color de la celda
    Color cellColor;

    if (widget.cell.symbol != null) {
      // Si la celda tiene un símbolo, usar un color definido (por ejemplo, azul claro)
      cellColor = Colors.grey.withOpacity(0.5);
    } else if (isTapped) {
      // Si la celda está siendo tocada, usar un color con opacidad
      cellColor = Colors.grey.withOpacity(0.5);
    } else {
      // Color por defecto
      cellColor = Colors.white;
    }

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isTapped = false;
        });
        if (widget.cell.symbol == null) {
          widget.onTap();
        }
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: cellColor,
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
