import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';

class FilterBottomSheet extends StatelessWidget {
  final VoidCallback onApplyFilter;
  const FilterBottomSheet({super.key, required this.onApplyFilter});

  @override
  Widget build(BuildContext context) {
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();

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
              suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
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
              suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
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
  }
}
