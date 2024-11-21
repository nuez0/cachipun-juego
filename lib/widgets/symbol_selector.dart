import 'package:flutter/material.dart';
import '../models/symbol.dart';

class SymbolSelector extends StatelessWidget {
  final Function(Symbol) onSymbolSelected;

  SymbolSelector({required this.onSymbolSelected});

  @override
  Widget build(BuildContext context) {
    // List of selectable symbols
    List<Symbol> symbols = [
      Symbol.rock,
      Symbol.paper,
      Symbol.scissors,
      Symbol.equal,
      Symbol.different,
      Symbol.winsRight,
      Symbol.winsLeft,
    ];

    return GridView.count(
      crossAxisCount: 4,
      children: symbols.map((symbol) {
        String displaySymbol;
        // Map Symbol to displayable characters
        switch (symbol) {
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
          onTap: () => onSymbolSelected(symbol),
          child: Card(
            child: Center(
              child: Text(
                displaySymbol,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
