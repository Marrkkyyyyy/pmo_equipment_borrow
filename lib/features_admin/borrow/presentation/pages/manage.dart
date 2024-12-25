import 'package:pmo_equipment_borrow/core/widgets/drawer.dart';
import 'package:pmo_equipment_borrow/core/widgets/scanner.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Manage extends StatefulWidget {
  const Manage({super.key});

  @override
  _ManageBorrowingPageState createState() => _ManageBorrowingPageState();
}

class _ManageBorrowingPageState extends State<Manage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController userIdController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController borrowDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    userIdController.dispose();
    returnDateController.dispose();
    borrowDateController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Borrowing'),
        backgroundColor: AppColor.navyBlue,
        bottom: TabBar(
          indicatorColor: AppColor.lightGray,
          labelColor: AppColor.white,
          unselectedLabelColor: Colors.white38,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Borrowed'),
            Tab(text: 'Returned'),
            Tab(text: 'Reserved'),
          ],
        ),
      ),
      drawer: const AdminDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBorrowAndBorrowedTab(),
          _buildReturnHistoryTab(),
          _buildReservedItemsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Borrow"),
        backgroundColor: AppColor.tealGreen,
        onPressed: () => _showBorrowForm(context),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBorrowAndBorrowedTab() {
    final borrowedItems = [
      {
        'equipmentName': 'Laptop',
        'borrowerName': 'John Doe',
        'dueDate': '2024-10-30',
      },
      {
        'equipmentName': 'Projector',
        'borrowerName': 'Jane Smith',
        'dueDate': '2024-11-01',
      },
      // Add more items as needed
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    hintText: 'Search equipment, name, or ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 16.0),
                  ),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () => _showFilterBottomSheet(context),
                icon: const Icon(Icons.filter_list),
                label: const Text("Filter"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.tealGreen,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Expanded ListView for dynamically displaying borrowed items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: borrowedItems.length,
            itemBuilder: (context, index) {
              final item = borrowedItems[index];
              return _buildBorrowedItemCard(
                equipmentName: item['equipmentName']!,
                borrowerName: item['borrowerName']!,
                dueDate: item['dueDate']!,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBorrowedItemCard({
    required String equipmentName,
    required String borrowerName,
    required String dueDate,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              equipmentName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.person, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  borrowerName,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Due Date: $dueDate',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showReturnDialog(equipmentName, borrowerName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.tealGreen,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Return'),
            ),
          ],
        ),
      ),
    );
  }

  void _showBorrowForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Borrow New Item',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildBorrowNewItemTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBorrowNewItemTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'School ID',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: userIdController,
                decoration: InputDecoration(
                  labelText: 'School ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                final barcodeResult = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context1) {
                    return CustomScanner(
                      onBarcodeDetected: (barcode) {
                        Navigator.of(context1).pop(barcode);
                      },
                    );
                  },
                );
                if (barcodeResult != null) {
                  userIdController.text = barcodeResult;
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.tealGreen,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Icon(Icons.qr_code_scanner),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Select Equipment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Equipment',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: ['Laptop', 'Projector', 'Printer'].map((String equipment) {
            return DropdownMenuItem<String>(
              value: equipment,
              child: Text(equipment),
            );
          }).toList(),
          onChanged: (String? value) {
            // Handle equipment selection
          },
        ),
        const SizedBox(height: 20),
        const Text(
          'Select Borrow Date',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: borrowDateController,
          decoration: InputDecoration(
            labelText: 'Borrow Date',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (selectedDate != null) {
              borrowDateController.text =
                  DateFormat('yyyy-MM-dd').format(selectedDate);
            }
          },
        ),
        const SizedBox(height: 20),
        const Text(
          'Select Return Date',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: returnDateController,
          decoration: InputDecoration(
            labelText: 'Return Date',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (selectedDate != null) {
              returnDateController.text =
                  DateFormat('yyyy-MM-dd').format(selectedDate);
            }
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.tealGreen,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Complete',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildReturnHistoryTab() {
    // Sample data for returned items (replace with actual data fetching logic)
    final returnHistory = [
      {
        'equipmentName': 'Projector',
        'returnDate': '2024-10-25',
        'condition': 'Good',
        'notes': 'Checked and working well.',
        'user': 'Jane Smith',
      },
      {
        'equipmentName': 'Laptop',
        'returnDate': '2024-10-20',
        'condition': 'Damaged',
        'notes': 'Screen cracked.',
        'user': 'John Doe',
      },
    ];

    return Column(
      children: [
        // Filter Button and Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    hintText: 'Search equipment, name, or ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 16.0),
                  ),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () => _showFilterBottomSheet(context),
                icon: const Icon(Icons.filter_list),
                label: const Text("Filter"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.tealGreen,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        // List of Returned Items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: returnHistory.length,
            itemBuilder: (context, index) {
              final item = returnHistory[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['equipmentName']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'By: ${item['user']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Return Date
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              color: Colors.grey, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Returned on: ${item['returnDate']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Condition Badge
                      Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.grey, size: 18),
                          const SizedBox(width: 8),
                          _buildConditionBadge(item['condition']!),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Notes Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.notes, color: Colors.grey, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item['notes'] ?? 'No additional notes',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

// Function to show the bottom sheet with filter options
  void _showFilterBottomSheet(BuildContext context) {
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Filter Return History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Start Date Filter Field
              TextFormField(
                controller: startDateController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon:
                      const Icon(Icons.calendar_today, color: Colors.grey),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    startDateController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
              ),
              const SizedBox(height: 16),
              // End Date Filter Field
              TextFormField(
                controller: endDateController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  labelText: 'End Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon:
                      const Icon(Icons.calendar_today, color: Colors.grey),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    endDateController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement filter logic here using startDateController.text and endDateController.text
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.tealGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Apply Filter',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  /// A helper widget to display a condition badge with color coding.
  Widget _buildConditionBadge(String condition) {
    Color badgeColor;
    if (condition == 'Good') {
      badgeColor = Colors.green;
    } else if (condition == 'Damaged') {
      badgeColor = Colors.red;
    } else {
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

  Widget _buildReservedItemsTab() {
    // Sample data for reserved items
    final reservedItems = [
      {
        'equipmentName': 'Printer',
        'user': {
          'userID': 'U001',
          'firstName': 'Michael',
          'lastName': 'Johnson',
          'schoolID': 'S12345',
          'department': 'BSBA'
        },
      },
      {
        'equipmentName': 'Projector',
        'user': {
          'userID': 'U002',
          'firstName': 'Sarah',
          'lastName': 'Lee',
          'schoolID': 'S67890',
          'department': 'CICT'
        },
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: reservedItems.length,
      itemBuilder: (context, index) {
        final Map<String, dynamic> item =
            reservedItems[index]; // Change to dynamic
        final Map<String, dynamic>? user =
            item['user'] as Map<String, dynamic>?; // Safely cast user

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['equipmentName'] as String? ?? 'Unknown Equipment',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Display additional user information with null checks
                if (user != null) ...[
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.grey, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        '${user['firstName'] ?? 'Unknown'} ${user['lastName'] ?? 'Unknown'} (ID: ${user['schoolID'] ?? 'N/A'})',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.school, color: Colors.grey, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Department: ${user['department'] ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showApproveDialog(context, item),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.tealGreen,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Approve'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement cancel logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showApproveDialog(BuildContext context, Map<String, dynamic> item) {
    DateTime borrowDate = DateTime.now();
    DateTime returnDate = DateTime.now().add(const Duration(days: 7));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section with subtle background
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Approve Reservation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Borrow Date
                const Text(
                  'Borrow Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: TextEditingController(
                      text: DateFormat('yyyy-MM-dd').format(borrowDate)),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon:
                        const Icon(Icons.calendar_today, color: Colors.grey),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: borrowDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(), // Cannot select future dates
                    );
                    if (pickedDate != null && pickedDate != borrowDate) {
                      borrowDate = pickedDate;
                      (context as Element).markNeedsBuild(); // Refresh UI
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Return Date
                const Text(
                  'Return Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: TextEditingController(
                      text: DateFormat('yyyy-MM-dd').format(returnDate)),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon:
                        const Icon(Icons.calendar_today, color: Colors.grey),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: returnDate,
                      firstDate: DateTime.now(), // Cannot select past dates
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null && pickedDate != returnDate) {
                      returnDate = pickedDate;
                      (context as Element).markNeedsBuild(); // Refresh UI
                    }
                  },
                ),
                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent, // Remove button shadow
                        side: BorderSide(
                          color: Colors.grey.shade400, // Set border color
                          width: 1,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors
                              .grey, // Set text color to grey for a "secondary" look
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement approve logic with borrowDate and returnDate
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.tealGreen,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReturnDialog(String equipment, String user) {
    TextEditingController notesController = TextEditingController();
    DateTime selectedReturnDate =
        DateTime.now(); // Initialize with the current date

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section with subtle background
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Return Equipment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Return Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: TextEditingController(
                      text:
                          DateFormat('yyyy-MM-dd').format(selectedReturnDate)),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon:
                        const Icon(Icons.calendar_today, color: Colors.grey),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime(2000), // Set the earliest selectable date
                      lastDate: DateTime
                          .now(), // Prevents selecting a date in the future
                    );

                    if (pickedDate != null &&
                        pickedDate != selectedReturnDate) {
                      setState(() {
                        selectedReturnDate = pickedDate; // Update selected date
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),

                // Condition Dropdown
                const Text(
                  'Condition',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                  ),
                  hint: const Center(
                    child: Text(
                      'Select Condition',
                      style: TextStyle(
                          color: Colors
                              .grey), // Set color to match hint text style
                    ),
                  ),
                  items: ['Good', 'Damaged'].map((String condition) {
                    return DropdownMenuItem<String>(
                      value: condition,
                      child: Text(condition),
                    );
                  }).toList(),
                  onChanged: (String? value) {},
                  validator: (value) =>
                      value == null ? 'Please select a condition' : null,
                ),

                const SizedBox(height: 20),

                // Notes Text Field
                const Text(
                  'Notes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: notesController,
                  decoration: InputDecoration(
                    hintText: 'Add notes...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent, // Remove button shadow
                        side: BorderSide(
                          color: Colors.grey.shade400, // Set border color
                          width: 1,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors
                              .grey, // Set text color to grey for a "secondary" look
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.tealGreen,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Confirm Return',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
