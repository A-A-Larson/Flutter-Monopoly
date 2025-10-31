// dart
// File: lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/game_controller.dart';

void main() {
  runApp(const MonopolyPassAndPlay());
}

class MonopolyPassAndPlay extends StatelessWidget {
  const MonopolyPassAndPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Monopoly Pass & Play (MVP)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = Get.put(GameController());
    // initialize 2 players for MVP; you can change to prompt later
    if (gc.players.isEmpty) gc.initPlayers(2);

    return Scaffold(
      appBar: AppBar(title: const Text('Monopoly - Pass & Play (MVP)')),
      body: Column(
        children: [
          // Board placeholder (portrait)
          Expanded(
            flex: 6,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/board.png',
                  fit: BoxFit.contain,
                  // If the image fails to load, show the original placeholder and a short message.
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.toys, size: 48, color: Colors.black26),
                        const SizedBox(height: 8),
                        const Text(
                          'Board image not found\n(ensure assets and pubspec.yaml are correct)',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),

          // Player area and actions
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  // Player list
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: gc.players.map((p) {
                        final isCurrent = p.id == gc.currentPlayer.id;
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isCurrent ? Colors.yellow.shade200 : Colors.white,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(p.name),
                              const SizedBox(height: 4),
                              Text('\$${p.money}'),
                              const SizedBox(height: 4),
                              Text('Pos: ${p.position}'),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }),

                  const SizedBox(height: 12),

                  // Dice and buy buttons
                  Obx(() {
                    final cp = gc.currentPlayer;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: gc.rollDice,
                          child: Column(
                            children: [
                              const Icon(Icons.casino),
                              const SizedBox(height: 4),
                              Text('Roll (Last: ${gc.lastRoll.value})'),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: gc.canBuy.value ? gc.buyProperty : null,
                          child: const Text('Buy Property'),
                        ),
                        ElevatedButton(
                          onPressed: gc.endTurn,
                          child: const Text('End Turn'),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 12),

                  // Log
                  Expanded(
                    child: Obx(() {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView(
                          children: gc.log.reversed.map((e) => Text(e)).toList(),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
