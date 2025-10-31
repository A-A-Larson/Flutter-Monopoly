// dart
// File: lib/models/property.dart
import 'package:flutter/foundation.dart';

class Property {
  final int position;
  final String name;
  final String colorGroup; // e.g. "Brown", "Light Blue", "Railroad", "Utility"
  final int price;
  final List<int> rent; // base rent and rents with houses/hotel; for railroads/utilities use conventions
  final int houseCost;
  final int mortgageValue;

  // Mutable runtime state
  int ownerId; // -1 = unowned
  int houses; // 0..5 (5 == hotel)

  Property({
    required this.position,
    required this.name,
    required this.colorGroup,
    required this.price,
    required this.rent,
    required this.houseCost,
    required this.mortgageValue,
    this.ownerId = -1,
    this.houses = 0,
  });

  bool get isOwned => ownerId != -1;
}
