import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';
import 'package:pmo_equipment_borrow/core/widgets/drawer.dart';
import 'package:pmo_equipment_borrow/features_admin/borrow/presentation/controllers/manage_borrowing_controller.dart';
import 'package:pmo_equipment_borrow/features_admin/borrow/presentation/widgets/borrow_new_item.dart';
import 'package:pmo_equipment_borrow/features_admin/borrow/presentation/widgets/search_filter.dart';

import '../widgets/borrowed_item_card.dart';
import '../widgets/returned_item_card.dart';
import '../widgets/reserved_item_card.dart';

class ManageBorrowingPage extends GetView<ManageBorrowingController> {
  const ManageBorrowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const AdminDrawer(),
        appBar: AppBar(
          title: const Text('Manage Borrowing'),
          backgroundColor: AppColor.navyBlue,
          bottom: TabBar(
            indicatorColor: AppColor.lightGray,
            labelColor: AppColor.white,
            unselectedLabelColor: Colors.white38,
            controller: controller.tabController,
            tabs: const [
              Tab(text: 'Borrowed'),
              Tab(text: 'Returned'),
              Tab(text: 'Reserved'),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            Obx(() => Column(
                  children: [
                    const SearchFilter(),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, bottom: 10.0),
                        itemCount: controller.borrowedItems.length,
                        itemBuilder: (context, index) {
                          final item = controller.borrowedItems[index];
                          return BorrowedItemCard(
                            equipmentName: item['equipmentName']!,
                            borrowerName: item['borrowerName']!,
                            dueDate: item['dueDate']!,
                          );
                        },
                      ),
                    ),
                  ],
                )),
            Obx(() => Column(
                  children: [
                    const SearchFilter(),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, bottom: 10.0),
                        itemCount: controller.returnHistory.length,
                        itemBuilder: (context, index) {
                          final item = controller.returnHistory[index];
                          return ReturnedItemCard(
                            equipmentName: item['equipmentName']!,
                            returnDate: item['returnDate']!,
                            condition: item['condition']!,
                            notes: item['notes']!,
                            user: item['user']!,
                          );
                        },
                      ),
                    ),
                  ],
                )),
            Obx(() => ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16, bottom: 10.0),
                  itemCount: controller.reservedItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.reservedItems[index];
                    return ReservedItemCard(
                      equipmentName: item['equipmentName']!,
                      user: item['user']!,
                    );
                  },
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Borrow"),
          backgroundColor: AppColor.tealGreen,
          icon: const Icon(Icons.add),
          onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const BorrowNewItem()),
        ),
      ),
    );
  }
}
