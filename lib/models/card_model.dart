// dart
// File: lib/models/card_model.dart
enum CardEffectType {
  moveTo,
  receive,
  pay,
  goToJail,
  getOutOfJailFree,
  payEachPlayer,
  collectFromPlayers,
  repairs,
}

class CardModel {
  final String text;
  final CardEffectType type;
  final int amount; // money amount or target position depending on type
  final int? targetPosition;

  CardModel({
    required this.text,
    required this.type,
    this.amount = 0,
    this.targetPosition,
  });
}
