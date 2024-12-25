import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmo_equipment_borrow/core/constant/app_strings.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';

class FilterButtons extends StatelessWidget {
  final RxString filterStatus;
  final Function(String) onFilterSelected;

  const FilterButtons({
    super.key,
    required this.filterStatus,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: AppStrings.filters.map((status) {
        return Obx(() {
          final isSelected = filterStatus.value == status;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ElevatedButton(
                onPressed: () => onFilterSelected(status),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? AppColor.tealGreen : Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        });
      }).toList(),
    );
  }
}
