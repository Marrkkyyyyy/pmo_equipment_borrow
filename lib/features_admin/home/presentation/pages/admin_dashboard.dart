import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';
import 'package:pmo_equipment_borrow/core/widgets/drawer.dart';
import 'package:pmo_equipment_borrow/features_admin/home/presentation/widgets/custom_recent_activities.dart';
import 'package:pmo_equipment_borrow/features_admin/home/presentation/widgets/custom_statistic.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
        backgroundColor: AppColor.navyBlue,
      ),
      drawer: const AdminDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomStatistic(),
            const SizedBox(height: 20),
            const Text(
              'Recent Activities',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(child: CustomRecentActivities()),
          ],
        ),
      ),
    );
  }

 
}
