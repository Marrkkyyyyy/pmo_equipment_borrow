import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';
import 'package:pmo_equipment_borrow/routes/routes.dart';
import 'package:intl/intl.dart';

/// User Dashboard Page displays equipment list, current borrowed items, and borrowing history.
class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({super.key});

  @override
  _UserDashboardPageState createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage>
    with SingleTickerProviderStateMixin {
  String formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat('EEEE, MMM d, yyyy').format(parsedDate);
  }

  late TabController _tabController;
  String _searchQuery = "";

  final equipmentList = [
    {'equipmentName': 'Scanner', 'status': 'Available'},
    {'equipmentName': 'Monitor', 'status': 'Not Available'},
    {'equipmentName': 'Tablet', 'status': 'Available'},
    {'equipmentName': 'Laptop', 'status': 'Not Available'},
    {'equipmentName': 'Projector', 'status': 'Available'},
    {'equipmentName': 'Printer', 'status': 'Not Available'},
    {'equipmentName': 'Camera', 'status': 'Available'},
    {'equipmentName': 'Microphone', 'status': 'Available'},
    {'equipmentName': 'Speakers', 'status': 'Not Available'},
  ];

  final currentBorrowed = [
    {
      'equipmentName': 'Laptop',
      'borrowDate': '2024-11-01',
      'dueDate': '2024-11-10'
    },
    {
      'equipmentName': 'Projector',
      'borrowDate': '2024-11-02',
      'dueDate': '2024-11-12'
    },
    {
      'equipmentName': 'Tablet',
      'borrowDate': '2024-11-03',
      'dueDate': '2024-11-13'
    },
    {
      'equipmentName': 'Camera',
      'borrowDate': '2024-11-05',
      'dueDate': '2024-11-15'
    },
    {
      'equipmentName': 'Microphone',
      'borrowDate': '2024-11-06',
      'dueDate': '2024-11-16'
    },
  ];

  final borrowingHistory = [
    {'equipmentName': 'Projector', 'returnDate': '2024-10-20'},
    {'equipmentName': 'Tablet', 'returnDate': '2024-09-15'},
    {'equipmentName': 'Scanner', 'returnDate': '2024-08-10'},
    {'equipmentName': 'Printer', 'returnDate': '2024-07-05'},
    {'equipmentName': 'Monitor', 'returnDate': '2024-06-25'},
    {'equipmentName': 'Speakers', 'returnDate': '2024-05-30'},
    {'equipmentName': 'Camera', 'returnDate': '2024-04-18'},
    {'equipmentName': 'Microphone', 'returnDate': '2024-03-10'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
        backgroundColor: AppColor.userDeepBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          indicatorColor: AppColor.lightGray,
          unselectedLabelColor: Colors.white38,
          labelColor: AppColor.white,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Equipment'),
            Tab(text: 'Borrowed'),
            Tab(text: 'History'),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEquipmentList(),
          _buildCurrentBorrowedList(),
          _buildBorrowingHistoryList(),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColor.userDeepBlue,
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 32),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'User Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'user@sample.com',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            onTap: () => Get.back(),
          ),
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
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        decoration: InputDecoration(
          hintText: 'Search equipment...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildEquipmentList() {
    final filteredEquipment = equipmentList.where((equipment) {
      return equipment['equipmentName']!.toLowerCase().contains(_searchQuery);
    }).toList();

    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            itemCount: filteredEquipment.length,
            itemBuilder: (context, index) {
              final equipment = filteredEquipment[index];
              final isAvailable = equipment['status'] == 'Available';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  leading: Icon(
                    Icons.category,
                    size: 40,
                    color: isAvailable ? AppColor.tealGreen : Colors.grey,
                  ),
                  title: Text(
                    equipment['equipmentName']!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        isAvailable ? Icons.check_circle : Icons.cancel,
                        color: isAvailable ? AppColor.tealGreen : Colors.red,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isAvailable ? 'Available' : 'Not Available',
                        style: TextStyle(
                          color: isAvailable ? AppColor.tealGreen : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  trailing: isAvailable
                      ? Tooltip(
                          message: 'Reserve this item',
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Implement Reserve functionality
                            },
                            icon: const Icon(Icons.add, size: 20),
                            label: const Text('Reserve'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.tealGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                          ),
                        )
                      : const Text(
                          'Unavailable',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentBorrowedList() {
    final filteredCurrentBorrowed = currentBorrowed.where((equipment) {
      return equipment['equipmentName']!.toLowerCase().contains(_searchQuery);
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      itemCount: filteredCurrentBorrowed.length,
      itemBuilder: (context, index) {
        final equipment = filteredCurrentBorrowed[index];
        return Card(
          elevation: 4, // Slight elevation for depth
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.assignment_outlined,
                    color: AppColor.tealGreen,
                    size: 40,
                  ),
                  title: Text(
                    equipment['equipmentName']!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                const Divider(), // Divider between sections for clarity
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              color: Colors.blueGrey, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Borrow Date: ${formatDate(equipment['borrowDate'] ?? '')}',
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.event_available,
                              color: Colors.deepOrange, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Due Date: ${formatDate(equipment['dueDate'] ?? '')}',
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the list of previously borrowed equipment with enhanced visual presentation for history items.
  Widget _buildBorrowingHistoryList() {
    final filteredBorrowingHistory = borrowingHistory.where((equipment) {
      return equipment['equipmentName']!.toLowerCase().contains(_searchQuery);
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      itemCount: filteredBorrowingHistory.length,
      itemBuilder: (context, index) {
        final equipment = filteredBorrowingHistory[index];
        return Card(
          elevation: 4, // Slight elevation for depth
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.history_outlined,
                    color: Colors.grey,
                    size: 40,
                  ),
                  title: Text(
                    equipment['equipmentName']!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.event, color: Colors.blueGrey, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'Return Date: ${formatDate(equipment['returnDate'] ?? '')}',
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColor.userDeepBlue),
      title: Text(
        label,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColor.userDeepBlue),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      dense: true,
    );
  }
}
