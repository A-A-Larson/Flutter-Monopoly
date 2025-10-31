// dart
// File: lib/models/player.dart
class Player {
  final int id;
  final String name;
  int money;
  int position;
  String tokenAsset; // placeholder asset path or token id
  bool inJail;
  int jailTurns;
  int get netWorth => money; // extend to include property values later

  Player({
    required this.id,
    required this.name,
    this.money = 1500,
    this.position = 0,
    this.tokenAsset = '',
    this.inJail = false,
    this.jailTurns = 0,
  });
}
