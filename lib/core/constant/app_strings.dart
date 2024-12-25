class AppStrings {
  static const String appName = 'PMO Inventory System';
  static const List<String> departments = [
    'BSBA',
    'CICT',
    'BSEd',
  ];
  static const List<String> filters = [
    'All',
    'Available',
    'Borrowed',
    'Reserved'
  ];
  static const List<String> status = [
    'Available',
    'Borrowed',
    'Reserved',
  ];
  static const List<String> conditions = [
    'Good',
    'Damaged',
  ];
  static const List<String> userRole = [
    'Admin',
    'Staff',
  ];

  static const List<Map<String, String>> users = [
    {
      'adminID': 'A001',
      'firstName': 'John',
      'lastName': 'Doe',
      'userRole': 'Admin',
      'email': 'john.doe@example.com',
    },
    {
      'adminID': 'A002',
      'firstName': 'Jane',
      'lastName': 'Smith',
      'userRole': 'Manager',
      'email': 'jane.smith@example.com',
    },
  ];
}
