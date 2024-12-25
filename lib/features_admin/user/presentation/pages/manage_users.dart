import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/constant/app_strings.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';
import 'package:pmo_equipment_borrow/core/widgets/drawer.dart';
import 'package:pmo_equipment_borrow/features_admin/user/presentation/widgets/add_update_user_dialog.dart';
import 'package:pmo_equipment_borrow/features_admin/user/presentation/widgets/user_card.dart';

class ManageUsersPage extends StatelessWidget {
  const ManageUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
        backgroundColor: AppColor.navyBlue,
      ),
      drawer: const AdminDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return const AddUpdateUserDialog();
          },
        ),
        label: const Text("Add New User"),
        icon: const Icon(Icons.add),
        backgroundColor: AppColor.tealGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: AppStrings.users.length,
                itemBuilder: (context, index) {
                  final user = AppStrings.users[index];
                  return UserCard(user: user);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
