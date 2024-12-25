import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageEquipmentController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var equipmentList = <Map<String, String>>[
    {'name': 'Laptop', 'condition': 'Good', 'status': 'Available'},
    {'name': 'Projector', 'condition': 'Damaged', 'status': 'Borrowed'},
    {'name': 'Printer', 'condition': 'Good', 'status': 'Reserved'},
  ].obs;

  var filterStatus = 'All'.obs;

  void addOrUpdateEquipment(Map<String, String> newData,
      [Map<String, String>? existingData]) {
    if (existingData != null) {
      int index = equipmentList.indexOf(existingData);
      equipmentList[index] = newData;
    } else {
      equipmentList.add(newData);
    }
  }

  void deleteEquipment(Map<String, String> equipment) {
    equipmentList.remove(equipment);
  }
}
