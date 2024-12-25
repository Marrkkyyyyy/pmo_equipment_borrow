import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';

class CustomRecentActivities extends StatelessWidget {
  CustomRecentActivities({super.key});
  final activities = [
    {'activity': 'John Doe borrowed a laptop.', 'date': 'Today'},
    {'activity': 'Jane Smith returned a projector.', 'date': 'Yesterday'},
    {'activity': 'Michael Johnson borrowed a printer.', 'date': '2 days ago'},
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            leading: const Icon(Icons.history, color: AppColor.tealGreen),
            title: Text(activities[index]['activity']!),
            subtitle: Text(activities[index]['date']!),
          ),
        );
      },
    );
  }
}
