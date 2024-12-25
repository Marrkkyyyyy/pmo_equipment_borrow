import 'package:flutter/material.dart';

class StatusHelper {
  /// Returns an icon based on the status.
  static IconData getStatusIcon(String status) {
    switch (status) {
      case 'Available':
        return Icons.check_circle;
      case 'Borrowed':
        return Icons.hourglass_empty;
      case 'Reserved':
        return Icons.bookmark;
      default:
        return Icons.help;
    }
  }

  /// Returns a color based on the status.
  static Color getStatusColor(String status) {
    switch (status) {
      case 'Available':
        return Colors.green;
      case 'Borrowed':
        return Colors.orange;
      case 'Reserved':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
