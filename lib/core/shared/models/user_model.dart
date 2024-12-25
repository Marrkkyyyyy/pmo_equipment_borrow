class User {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  User(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName});
}

class RegularUser extends User {
  final String schoolID;
  final String department;

  RegularUser(
      {required this.schoolID,
      required this.department,
      required super.email,
      required super.password,
      required super.firstName,
      required super.lastName});
}

class AdminUser extends User {
  final String role;

  AdminUser(
      {required this.role,
      required super.email,
      required super.password,
      required super.firstName,
      required super.lastName});
}
