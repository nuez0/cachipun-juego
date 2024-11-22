import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final String symbol;

  DividerWidget({required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: symbol != null
            ? Center(
                child: Text(
                  symbol,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            : Container(), // Si no hay símbolo, mostrar un divisor vacío
      ),
    );
  }
}
