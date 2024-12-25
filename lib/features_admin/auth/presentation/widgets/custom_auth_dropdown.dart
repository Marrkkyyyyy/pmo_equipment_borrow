import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';

class CustomAuthDropdown extends StatelessWidget {
  const CustomAuthDropdown(
      {super.key, required this.items, required this.labelText});
  final List<String> items;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon:
            const Icon(Icons.account_balance, color: AppColor.tealGreen),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: items.map((String department) {
        return DropdownMenuItem<String>(
          value: department,
          child: Text(department),
        );
      }).toList(),
      onChanged: (String? value) {},
    );
  }
}
