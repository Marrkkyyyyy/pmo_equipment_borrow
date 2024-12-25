import 'package:flutter/material.dart';

class ConditionBadge extends StatelessWidget {
  final String condition;
  const ConditionBadge({super.key, required this.condition});
  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    switch (condition) {
      case 'Good':
        badgeColor = Colors.green;
        break;
      case 'Damaged':
        badgeColor = Colors.red;
        break;
      default:
        badgeColor = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        condition,
        style: TextStyle(
          color: badgeColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
