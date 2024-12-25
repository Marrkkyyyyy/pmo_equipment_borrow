import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';
import 'package:pmo_equipment_borrow/routes/routes.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColor.tealGreen,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Admin Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'admin@sample.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildSectionTitle('Navigation'),
                _buildDrawerItem(
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoute.ADMIN_DASHBOARD_PAGE);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.group,
                  label: 'Manage Users',
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoute.MANAGE_USERS_PAGE);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.inventory,
                  label: 'Manage Equipment',
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoute.MANAGE_EQUIPMENT_PAGE);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.assignment,
                  label: 'Manage Borrowing',
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoute.MANAGE_BORROWING_PAGE);
                  },
                ),
                _buildSectionTitle('Settings'),
                _buildDrawerItem(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () => Get.back(),
                ),
                _buildDrawerItem(
                  icon: Icons.logout,
                  label: 'Logout',
                  onTap: () {
                    Get.offAllNamed(AppRoute.LOGIN_PAGE);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper method to build section titles
Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
    ),
  );
}

// Improved Drawer Item with hover effect
Widget _buildDrawerItem({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppColor.tealGreen),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    ),
  );
}
