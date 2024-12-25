import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/features_admin/user/presentation/widgets/add_update_user_dialog.dart';
import 'package:pmo_equipment_borrow/features_admin/user/presentation/widgets/delete_user_dialog.dart';

class UserCard extends StatelessWidget {
  final Map<String, String> user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 3,
      child: ListTile(
        title: Text('${user['firstName']} ${user['lastName']}'),
        subtitle: Text(user['email'] ?? ''),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return AddUpdateUserDialog(
                    user: {
                      'firstName': user['firstName'],
                      'lastName': user['lastName'],
                      'email': user['email'],
                      'userRole': user['userRole'],
                    },
                  );
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DeleteUserDialog();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
