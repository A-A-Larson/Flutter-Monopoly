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
  final canBuy = false.obs;

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
    player.position.value = (player.position.value + steps) % 40;
    log.add('${player.name} moved to ${player.position.value}');
    final landedProperty = getPropertyAt(player.position.value);
    if (landedProperty != null) {
      if (!landedProperty.isOwned) {
        canBuy.value = true;
        log.add('${player.name} can buy ${landedProperty.name} for \$${landedProperty.price}');
      } else if (landedProperty.ownerId != player.id) {
        final rent = _calculateRent(landedProperty);
        player.money.value -= rent;
        final owner = players.firstWhere((p) => p.id == landedProperty.ownerId);
        owner.money.value += rent;
        log.add('${player.name} paid \$${rent} rent to ${owner.name}');
      } else {
        log.add('${player.name} landed on their own property.');
      }
    } else {
      if (player.position.value == 0) {
        player.money.value += 200;
        log.add('${player.name} landed on GO and collected \$200');
      } else if (player.position.value == 4) {
        final tax = 200;
        player.money.value -= tax;
        log.add('${player.name} paid Income Tax \$${tax}');
      } else if (player.position.value == 30) {
        player.position.value = 10;
        player.inJail.value = true;
        log.add('${player.name} went to Jail');
      } else {
        log.add('${player.name} landed on a non-property square (${player.position.value})');
      }
      canBuy.value = false;
    }
  }

  int _calculateRent(Property p) {
    if (p.colorGroup == 'Railroad') {
      final count = properties.where((x) => x.colorGroup == 'Railroad' && x.ownerId == p.ownerId).length;
      return p.rent[(count - 1).clamp(0, p.rent.length - 1)];
    } else if (p.colorGroup == 'Utility') {
      return 0;
    } else {
      return p.rent[p.houses.clamp(0, p.rent.length - 1)];
    }
  }

  void buyProperty() {
    final player = currentPlayer;
    final prop = getPropertyAt(player.position.value);
    if (prop == null || prop.isOwned) return;
    if (player.money.value >= prop.price) {
      player.money.value -= prop.price;
      prop.ownerId = player.id;
      canBuy.value = false;
      log.add('${player.name} bought ${prop.name} for \$${prop.price}');
    } else {
      log.add('${player.name} does not have enough money to buy ${prop.name}');
    }
  }

  void endTurn() {
    currentPlayerIndex.value = (currentPlayerIndex.value + 1) % players.length;
    canBuy.value = false;
    log.add('Turn: ${currentPlayer.name}');
  }
}
