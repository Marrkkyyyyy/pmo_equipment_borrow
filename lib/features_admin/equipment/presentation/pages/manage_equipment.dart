import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';
import 'package:pmo_equipment_borrow/core/widgets/drawer.dart';
import 'package:pmo_equipment_borrow/features_admin/equipment/presentation/controllers/manage_equipment_controller.dart';
import 'package:pmo_equipment_borrow/features_admin/equipment/presentation/widgets/delete_equipment_dialog.dart';
import 'package:pmo_equipment_borrow/features_admin/equipment/presentation/widgets/equipment_card.dart';
import 'package:pmo_equipment_borrow/features_admin/equipment/presentation/widgets/equipment_form.dart';
import 'package:pmo_equipment_borrow/features_admin/equipment/presentation/widgets/filter_buttons.dart';
import 'package:pmo_equipment_borrow/features_admin/equipment/presentation/widgets/search_textfield.dart';

class ManageEquipment extends GetView<ManageEquipmentController> {
  const ManageEquipment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Equipment'),
        backgroundColor: AppColor.navyBlue,
      ),
      drawer: const AdminDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.tealGreen,
        label: const Text("Add New Equipment"),
        icon: const Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: EquipmentForm(
                  formKey: controller.formKey,
                  onPressed: () {},
                ),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            SearchTextfield(onChanged: (value) {}),
            FilterButtons(
              filterStatus: controller.filterStatus,
              onFilterSelected: (status) =>
                  controller.filterStatus.value = status,
            ),
            Expanded(
              child: Obx(() {
                var filteredList = controller.equipmentList.where((equipment) {
                  return controller.filterStatus.value == 'All' ||
                      equipment['status'] == controller.filterStatus.value;
                }).toList();

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 60),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final equipment = filteredList[index];
                    return EquipmentCard(
                      equipment: equipment,
                      onEdit: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: SingleChildScrollView(
                              child: EquipmentForm(
                                existingData: equipment,
                                formKey: controller.formKey,
                                onPressed: () {},
                              ),
                            ),
                          );
                        },
                      ),
                      onDelete: () => showDialog(
                          context: context,
                          builder: (context) {
                            return const DeleteEquipmentDialog();
                          }),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
