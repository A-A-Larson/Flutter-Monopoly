// dart
// File: lib/data/cards.dart
import '../models/card_model.dart';

final List<CardModel> communityChestCards = [
  CardModel(text: 'Advance to GO (Collect \$200)', type: CardEffectType.moveTo, amount: 200, targetPosition: 0),
  CardModel(text: 'Bank error in your favor. Collect \$200', type: CardEffectType.receive, amount: 200),
  CardModel(text: 'Doctor\'s fees. Pay \$50', type: CardEffectType.pay, amount: 50),
  CardModel(text: 'Get Out of Jail Free', type: CardEffectType.getOutOfJailFree),
  CardModel(text: 'Go to Jail. Go directly to jail. Do not pass GO, do not collect \$200', type: CardEffectType.goToJail),
  CardModel(text: 'Grand Opera Night. Collect \$50 from every player', type: CardEffectType.collectFromPlayers, amount: 50),
  CardModel(text: 'Holiday Fund matures. Receive \$100', type: CardEffectType.receive, amount: 100),
  CardModel(text: 'Income tax refund. Collect \$20', type: CardEffectType.receive, amount: 20),
  CardModel(text: 'Life insurance matures. Collect \$100', type: CardEffectType.receive, amount: 100),
  CardModel(text: 'Pay hospital fees of \$100', type: CardEffectType.pay, amount: 100),
  CardModel(text: 'Pay school fees of \$50', type: CardEffectType.pay, amount: 50),
  CardModel(text: 'Receive for services \$25', type: CardEffectType.receive, amount: 25),
  CardModel(text: 'You are assessed for street repairs: Pay \$40 per house and \$115 per hotel', type: CardEffectType.repairs),
  CardModel(text: 'You have won second prize in a beauty contest. Collect \$10', type: CardEffectType.receive, amount: 10),
  CardModel(text: 'Receive \$25 consultancy fee', type: CardEffectType.receive, amount: 25),
];

final List<CardModel> chanceCards = [
  CardModel(text: 'Advance to GO (Collect \$200)', type: CardEffectType.moveTo, amount: 200, targetPosition: 0),
  CardModel(text: 'Advance to Illinois Ave', type: CardEffectType.moveTo, targetPosition: 24),
  CardModel(text: 'Advance to St. Charles Place', type: CardEffectType.moveTo, targetPosition: 11),
  CardModel(text: 'Advance token to nearest Utility. If unowned, you may buy it. If owned, throw dice and pay owner 10x the amount thrown', type: CardEffectType.moveTo),
  CardModel(text: 'Bank pays you dividend of \$50', type: CardEffectType.receive, amount: 50),
  CardModel(text: 'Get Out of Jail Free', type: CardEffectType.getOutOfJailFree),
  CardModel(text: 'Go to Jail. Go directly to jail. Do not pass GO, do not collect \$200', type: CardEffectType.goToJail),
  CardModel(text: 'Go back 3 spaces', type: CardEffectType.moveTo, targetPosition: -3),
  CardModel(text: 'Pay poor tax of \$15', type: CardEffectType.pay, amount: 15),
  CardModel(text: 'Take a trip to Reading Railroad', type: CardEffectType.moveTo, targetPosition: 5),
  CardModel(text: 'You have been elected chairman of the board. Pay each player \$50', type: CardEffectType.payEachPlayer, amount: 50),
  CardModel(text: 'Your building loan matures. Collect \$150', type: CardEffectType.receive, amount: 150),
  CardModel(text: 'Make general repairs on all your property: For each house pay \$25; for each hotel pay \$100', type: CardEffectType.repairs),
];
