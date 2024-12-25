import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';
import 'package:pmo_equipment_borrow/features_admin/borrow/presentation/widgets/filterr_bottom_sheet.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
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
            onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => FilterBottomSheet(onApplyFilter: () {})),
            icon: const Icon(Icons.filter_list),
            label: const Text("Filter"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.tealGreen,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
