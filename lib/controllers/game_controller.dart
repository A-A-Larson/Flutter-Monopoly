// dart
// File: lib/controllers/game_controller.dart
import 'dart:math';
import 'package:get/get.dart';
import '../models/player.dart';
import '../models/property.dart';
import '../data/board.dart';

class GameController extends GetxController {
  final players = <Player>[].obs;
  final properties = standardProperties.obs;
  final currentPlayerIndex = 0.obs;
  final log = <String>[].obs;
  final lastRoll = 0.obs;
  final canBuy = false.obs; // true if current player can buy landed property

  Property? getPropertyAt(int pos) {
    return properties.firstWhereOrNull((p) => p.position == pos);
  }

  Player get currentPlayer => players[currentPlayerIndex.value];

  void initPlayers(int count) {
    players.clear();
    for (var i = 0; i < count; i++) {
      players.add(Player(id: i, name: 'Player ${i + 1}', tokenAsset: 'token_$i'));
    }
    currentPlayerIndex.value = 0;
    log.clear();
    log.add('Game started with $count players.');
  }

  void rollDice() {
    final rng = Random();
    final die = rng.nextInt(6) + 1;
    final die2 = rng.nextInt(6) + 1;
    final total = die + die2;
    lastRoll.value = total;
    log.add('${currentPlayer.name} rolled $die + $die2 = $total');
    moveCurrentPlayer(total);
  }

  void moveCurrentPlayer(int steps) {
    final player = currentPlayer;
    player.position = (player.position + steps) % 40;
    log.add('${player.name} moved to ${player.position}');
    final landedProperty = getPropertyAt(player.position);
    if (landedProperty != null) {
      if (!landedProperty.isOwned) {
        canBuy.value = true;
        log.add('${player.name} can buy ${landedProperty.name} for \$${landedProperty.price}');
      } else if (landedProperty.ownerId != player.id) {
        final rent = _calculateRent(landedProperty);
        player.money -= rent;
        final owner = players.firstWhere((p) => p.id == landedProperty.ownerId);
        owner.money += rent;
        log.add('${player.name} paid \$${rent} rent to ${owner.name}');
      } else {
        log.add('${player.name} landed on their own property.');
      }
    } else {
      // handle non-property squares (Go, Income Tax, Jail, Chance, Community Chest...) simplified here
      if (player.position == 0) {
        player.money += 200;
        log.add('${player.name} landed on GO and collected \$200');
      } else if (player.position == 4) {
        // Income Tax - simplified flat
        final tax = 200;
        player.money -= tax;
        log.add('${player.name} paid Income Tax \$${tax}');
      } else if (player.position == 30) {
        // Go to Jail
        player.position = 10;
        player.inJail = true;
        log.add('${player.name} went to Jail');
      } else {
        log.add('${player.name} landed on a non-property square (${player.position})');
      }
      canBuy.value = false;
    }
    update(); // notify listeners
  }

  int _calculateRent(Property p) {
    if (p.colorGroup == 'Railroad') {
      // count owned railroads
      final count = properties.where((x) => x.colorGroup == 'Railroad' && x.ownerId == p.ownerId).length;
      return p.rent[(count - 1).clamp(0, p.rent.length - 1)];
    } else if (p.colorGroup == 'Utility') {
      // handled outside with dice; fallback fixed
      return 0;
    } else {
      return p.rent[p.houses.clamp(0, p.rent.length - 1)];
    }
  }

  void buyProperty() {
    final player = currentPlayer;
    final prop = getPropertyAt(player.position);
    if (prop == null) return;
    if (prop.isOwned) return;
    if (player.money >= prop.price) {
      player.money -= prop.price;
      prop.ownerId = player.id;
      canBuy.value = false;
      log.add('${player.name} bought ${prop.name} for \$${prop.price}');
      update();
    } else {
      log.add('${player.name} does not have enough money to buy ${prop.name}');
    }
  }

  void endTurn() {
    canBuy.value = false;
    currentPlayerIndex.value = (currentPlayerIndex.value + 1) % players.length;
    log.add('Turn: ${currentPlayer.name}');
    update();
  }
}
