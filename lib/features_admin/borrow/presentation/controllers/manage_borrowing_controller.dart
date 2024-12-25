import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageBorrowingController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  var borrowedItems = <Map<String, String>>[].obs;
  var reservedItems = <Map<String, dynamic>>[].obs;
  var returnHistory = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    fetchBorrowedItems();
    fetchReservedItems();
    fetchReturnHistory();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void fetchBorrowedItems() {
    borrowedItems.assignAll([
      {
        'equipmentName': 'Laptop',
        'borrowerName': 'John Doe',
        'dueDate': '2024-10-30'
      },
      {
        'equipmentName': 'Projector',
        'borrowerName': 'Jane Smith',
        'dueDate': '2024-11-01'
      },
    ]);
  }

  void fetchReservedItems() {
    reservedItems.assignAll([
      {
        'equipmentName': 'Printer',
        'user': {
          'firstName': 'Michael',
          'lastName': 'Johnson',
          'schoolID': 'S12345',
          'department': 'BSIT',
        }
      },
    ]);
  }

  void fetchReturnHistory() {
    returnHistory.assignAll([
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
    ]);
  }
}
