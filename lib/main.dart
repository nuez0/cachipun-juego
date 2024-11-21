import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/providers/game_provider.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock-Paper-Scissors Grid Game',
      home: GameScreen(),
    );
  }
}
