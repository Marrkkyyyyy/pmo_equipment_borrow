import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/constant/app_strings.dart';

class EquipmentForm extends StatelessWidget {
  final Map<String, String>? existingData;
  final VoidCallback onPressed;
  final GlobalKey<FormState> formKey;

  const EquipmentForm({
    super.key,
    this.existingData,
    required this.onPressed,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final nameController =
        TextEditingController(text: existingData?['name'] ?? '');
    final condition = existingData?['condition'] ?? 'Good';
    final status = existingData?['status'] ?? 'Available';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  existingData != null ? 'Update Equipment' : 'Add Equipment',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Equipment Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the equipment name' : null,
            ),
            DropdownButtonFormField<String>(
              value: condition,
              items: AppStrings.conditions.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: const InputDecoration(labelText: 'Condition'),
            ),
            DropdownButtonFormField<String>(
              value: status,
              items: AppStrings.status.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                    double.infinity, 50), // Full width with height of 50
              ),
              child: Text(existingData != null ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
