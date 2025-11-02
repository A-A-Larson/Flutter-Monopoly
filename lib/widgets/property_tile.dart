import 'package:flutter/material.dart';
import '../models/property.dart';

class PropertyTile extends StatelessWidget {
  final Property property;

  const PropertyTile({
    Key? key,
    required this.property,
  }) : super(key: key);

  Color _getColorGroupColor() {
    switch (property.colorGroup.toLowerCase()) {
      case 'brown':
        return const Color(0xFF8B4513);
      case 'light blue':
        return const Color(0xFF87CEEB);
      case 'pink':
        return const Color(0xFFFF1493);
      case 'orange':
        return const Color(0xFFFFA500);
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'dark blue':
        return const Color(0xFF00008B);
      case 'railroad':
        return Colors.black;
      case 'utility':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Colored header bar
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: _getColorGroupColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
          ),
          // Property information
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text('Price: \$${property.price}'),
                  const SizedBox(height: 8),
                  Text('Rent: \$${property.rent[0]}'),
                  if (property.rent.length > 1) ...[
                    const SizedBox(height: 4),
                    Text('With 1 House: \$${property.rent[1]}'),
                    Text('With 2 Houses: \$${property.rent[2]}'),
                    Text('With 3 Houses: \$${property.rent[3]}'),
                    Text('With 4 Houses: \$${property.rent[4]}'),
                    if (property.rent.length > 5)
                      Text('With Hotel: \$${property.rent[5]}'),
                  ],
                  const Spacer(),
                  if (property.houseCost > 0)
                    Text('House Cost: \$${property.houseCost}'),
                  Text('Mortgage: \$${property.mortgageValue}'),
                  if (property.isOwned)
                    Text(
                      'Owner: Player ${property.ownerId}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
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
