import 'package:get/get.dart';

class Player {
  final int id;
  final String name;
  final String tokenAsset;
  final RxInt money = 1500.obs;
  final RxInt position = 0.obs;
  final RxBool inJail = false.obs;
  final RxInt jailTurns = 0.obs;
  final RxBool getOutOfJailFreeCard = false.obs;

  Player({
    required this.id,
    required this.name,
    required this.tokenAsset,
  });
}

